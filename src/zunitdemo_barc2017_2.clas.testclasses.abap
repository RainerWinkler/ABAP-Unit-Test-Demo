CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_2 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_barc2017_2.
    METHODS:
      setup,
      actual_date FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    TEST-INJECTION sy_datum.
      cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    END-TEST-INJECTION.
  ENDMETHOD.

  METHOD actual_date.

    TEST-INJECTION sy_datum.
      r_result = |20171110|.
    END-TEST-INJECTION.

    f_cut = NEW #( ).

    DATA: actual_day_act TYPE sy-datum.

    actual_day_act = f_cut->actual_date( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expect the correct day'
                                        exp = |20171110|
                                        act = actual_day_act ).


  ENDMETHOD.

ENDCLASS.
