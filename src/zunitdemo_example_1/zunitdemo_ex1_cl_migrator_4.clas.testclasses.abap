CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_ex1_cl_migrator_4 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA f_cut TYPE REF TO zunitdemo_ex1_cl_migrator_4.

    DATA: test_data TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY,
          expecteds TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.
    METHODS:
      setup,
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
    TEST-INJECTION sflight_select.
      " Do test seams correct. Otherwise tests may not work as expected
      " This coding is equivalent to a select statement
      DATA: sft TYPE sflight.
      LOOP AT test_container=>sflight_mock INTO sft WHERE carrid IN carrid_range.
        sfs = VALUE #( BASE sfs ( sft ) ).
      ENDLOOP.
    END-TEST-INJECTION.
    TEST-INJECTION sflight_modify.
      " Do test seams correct. Otherwise tests may not work as expected
      DATA: m TYPE sflight.
      FIELD-SYMBOLS: <f> TYPE sflight.
      LOOP AT modifieds INTO m.
        " This simulates a modify. All three key fields are checked.
        " This coding is equivalent to a modify statement on a database table
        READ TABLE test_container=>sflight_mock ASSIGNING <f> WITH KEY carrid = m-carrid connid = m-connid fldate = m-fldate.
        IF sy-subrc EQ 0.
          <f> = m.
        ENDIF.
      ENDLOOP.

    END-TEST-INJECTION.
  ENDMETHOD.

  METHOD simple.

    test_container=>sflight_mock = VALUE #( (
                                              carrid = |TST|
                                              connid = 1
                                              fldate = |20200101|
                                              price = 1
                                           ) ).

    _migrate( ).

    expecteds = VALUE #( (
                      carrid = |TST|
                      connid = 1
                      fldate = |20200101|
                      price = 2
                   ) ).

    _check( 'Expect correctly migrated data' ).

  ENDMETHOD.

  METHOD simple2.

    test_container=>sflight_mock = VALUE #( (
                                              carrid = |TST|
                                              connid = 1
                                              fldate = |20200101|
                                              price = 100
                                           ) ).

    _migrate( ).

    expecteds = VALUE #( (
                      carrid = |TST|
                      connid = 1
                      fldate = |20200101|
                      price = 110
                   ) ).

    _check( 'Expect correctly migrated data' ).

  ENDMETHOD.

  METHOD _migrate.

    " Migrate
    f_cut->migrate( carrid_range = VALUE #( ( sign = |I| option = |EQ| low = 'TST' ) ) ).
    COMMIT WORK AND WAIT.

  ENDMETHOD.


  METHOD _check.

    SORT test_container=>sflight_mock.
    SORT expecteds.
    cl_abap_unit_assert=>assert_equals( msg = message exp = expecteds act = test_container=>sflight_mock ).

  ENDMETHOD.

ENDCLASS.
