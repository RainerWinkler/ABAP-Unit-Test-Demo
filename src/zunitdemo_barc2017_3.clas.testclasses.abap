CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_barc2017_3 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_barc2017_3.
    METHODS:
      setup,
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

  ENDMETHOD.

  METHOD first_test.
    DATA : actual_day_act TYPE sy-datum.
    f_cut = NEW #( ).
    actual_day_act = f_cut->actual_day( ).
    cl_abap_unit_assert=>assert_equals( msg = 'Return actual'
                                        exp = |20171111|
                                        act = actual_day_act ).
  ENDMETHOD.

ENDCLASS.
