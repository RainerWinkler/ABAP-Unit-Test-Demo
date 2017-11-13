CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_5 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_barc2017_5.
    METHODS:
      setup,
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

    TEST-INJECTION sy_datum.
      cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    END-TEST-INJECTION.

  ENDMETHOD.

  METHOD first_test.

    f_cut = NEW #( ).
    DATA: actual_day_act TYPE sy-datum.

    TEST-INJECTION sy_datum.
      r_result = |20171113|.
    END-TEST-INJECTION.

    actual_day_act = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Return actual day'
                                        exp = |20171113| act = actual_day_act ).

  ENDMETHOD.

ENDCLASS.
