CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_6 DEFINITION LOCAL FRIENDS ltcl_test.

CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_barc2017_6.
    METHODS:
      setup,
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    TEST-INJECTION sy_datum.
    cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    end-TEST-INJECTION.
  ENDMETHOD.

  METHOD first_test.
    f_cut = NEW #( ).
    DATA: actual_day TYPE sy-datum.
    TEST-INJECTION sy_datum.
      r_result = |20171114|.
    end-test-INJECTION.
    actual_day = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Return actual date'
                                exp = |20171114| act = actual_day ).
  ENDMETHOD.

ENDCLASS.
