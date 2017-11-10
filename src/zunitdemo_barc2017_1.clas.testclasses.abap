class ltcl_test DEFINITION DEFERRED.
class zunitdemo_barc2017_1 DEFINITION LOCAL FRIENDS ltcl_test.
class ltcl_test definition final for testing
  duration short
  risk level harmless.

  private section.
    data: f_cut TYPE REF TO zunitdemo_barc2017_1.
    methods:
      setup,
      method1 for testing raising cx_static_check.
endclass.


class ltcl_test implementation.

  method setup.

  endmethod.

  method method1.

    f_cut = new #( ).
    data: actual_date_act TYPE sy-datum.
    actual_date_act = f_cut->method1( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Return today'
                                        exp = |20171110|
                                        act = actual_date_act ).

  endmethod.

endclass.
