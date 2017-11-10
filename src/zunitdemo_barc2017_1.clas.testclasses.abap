CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_1 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_barc2017_1.
    METHODS:
      setup,
      method1 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    TEST-INJECTION sy_datum.
      cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    END-TEST-INJECTION.

  ENDMETHOD.

  METHOD method1.

    TEST-INJECTION sy_datum.
      r_result = |20171110|.
    END-TEST-INJECTION.

    f_cut = NEW #( ).
    DATA: actual_date_act TYPE sy-datum.
    actual_date_act = f_cut->method1( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Return today'
                                        exp = |20171110|
                                        act = actual_date_act ).

  ENDMETHOD.

ENDCLASS.
