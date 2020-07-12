CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_ex1_cl_migrator_3 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA f_cut TYPE REF TO zunitdemo_ex1_cl_migrator_3.

    DATA: test_data TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY,
          expecteds TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.
    METHODS:
      setup,
      _prepare_test_data,
      _migrate,
      _check
        IMPORTING
          message TYPE string,
      simple FOR TESTING RAISING cx_static_check,
      simple2 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.

  METHOD simple.

    test_data = VALUE #( (
                            carrid = |TST|
                            connid = 1
                            fldate = |20200101|
                            price = 1
                         ) ).

    _prepare_test_data( ).
    _migrate( ).

    expecteds = VALUE #( (
                      mandt = sy-mandt
                      carrid = |TST|
                      connid = 1
                      fldate = |20200101|
                      price = 2
                   ) ).

    _check( 'Expect correctly migrated data' ).

  ENDMETHOD.

  METHOD simple2.

    test_data = VALUE #( (
                            carrid = |TST|
                            connid = 1
                            fldate = |20200101|
                            price = 100
                         ) ).

    _prepare_test_data( ).
    _migrate( ).

    expecteds = VALUE #( (
                      mandt = sy-mandt
                      carrid = |TST|
                      connid = 1
                      fldate = |20200101|
                      price = 110
                   ) ).

    _check( 'Expect correctly migrated data' ).

  ENDMETHOD.

  METHOD _prepare_test_data.

    " Prepare test data for migration
    DELETE FROM sflight WHERE carrid = 'TST'.
    COMMIT WORK AND WAIT.

    INSERT sflight FROM TABLE test_data.
    COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD _migrate.

    " Migrate
    f_cut->migrate( carrid_range = VALUE #( ( sign = |I| option = |EQ| low = 'TST' ) ) ).
    COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD _check.

    " Check

    DATA: actuals   TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.

    SELECT * FROM sflight INTO TABLE @actuals WHERE carrid = 'TST'.
    SORT actuals.
    SORT expecteds.
    cl_abap_unit_assert=>assert_equals( msg = message exp = expecteds act = actuals ).

  ENDMETHOD.

ENDCLASS.
