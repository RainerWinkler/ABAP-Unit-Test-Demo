class ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_4 DEFINITION LOCAL FRIENDS ltcl_test.
class ltcl_test definition final for testing
  duration short
  risk level harmless.

  private section.
    data f_cut TYPE REF TO zunitdemo_barc2017_4.
    methods:
      setup,
      first_test for testing raising cx_static_check.
endclass.


class ltcl_test implementation.

  method setup.
    test-INJECTION sy_datum.
      cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    end-TEST-INJECTION.
  endmethod.

  method first_test.

    data actual_date_act TYPE sy-datum.

    f_cut = new #( ).

    test-INJECTION sy_datum.
      r_result = |20171111|.
    end-TEST-INJECTION.

    actual_date_act = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Return the actual day'
                                        exp = |20171111|
                                        act = actual_date_act ).

  endmethod.

endclass.
