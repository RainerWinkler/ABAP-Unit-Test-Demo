CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_ex1_cl_migrator_2 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA f_cut TYPE REF TO zunitdemo_ex1_cl_migrator_2.
    METHODS:
      setup,
      simple FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.

  METHOD simple.

    " Prepare test data for migration
    DELETE FROM sflight WHERE carrid = 'TST'.
    COMMIT WORK AND WAIT.

    DATA: test_data TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.

    test_data = VALUE #( (
                            carrid = |TST|
                            connid = 1
                            fldate = |20200101|
                            price = 1
                         ) ).

    INSERT sflight FROM TABLE test_data.
    COMMIT WORK AND WAIT.

    " Migrate
    f_cut->migrate( carrid_range = VALUE #( ( sign = |I| option = |EQ| low = 'TST' ) ) ).
    COMMIT WORK AND WAIT.

    " Check correct migration
    DATA: expecteds TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY,
          actuals TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.
    expecteds = VALUE #( (
                      mandt = sy-mandt
                      carrid = |TST|
                      connid = 1
                      fldate = |20200101|
                      price = 2
                   ) ).

    SELECT * from sflight INTO TABLE @actuals WHERE carrid = 'TST'.

    cl_abap_unit_assert=>assert_equals( msg = 'Expect correctly migrated data' exp = expecteds act = actuals ).

  ENDMETHOD.

ENDCLASS.
