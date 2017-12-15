class ltcl_test definition DEFERRED.
class zunitdemo_barc2017_7 DEFINITION LOCAL FRIENDS ltcl_test.
class ltcl_test definition final for testing
  duration short
  risk level harmless.

  private section.
    data: f_cut TYPE REF TO zunitdemo_barc2017_7.
    methods:
      setup,
      first_test for testing raising cx_static_check.
endclass.


class ltcl_test implementation.

  method setup.

    TEST-INJECTION date.
      cl_abap_unit_assert=>fail( 'Redefine me' ).
    end-TEST-INJECTION.

  endmethod.

  method first_test.

    f_cut = new #( ).



    TEST-INJECTION date.
     date = |20171215|.
    end-TEST-INJECTION.

    data(date) = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg'
    exp = |20171215| act = date ).



  endmethod.

endclass.
