CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_simpl3.
    METHODS:
      actual_date FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD actual_date.

    f_cut = NEW #( ).

    DATA: actual_day_act TYPE numc2.

    TEST-INJECTION sy_datum.

      actual_date = '20170609'.

    END-TEST-INJECTION.

    actual_day_act = f_cut->actual_day( ).



    cl_abap_unit_assert=>assert_equals( msg = 'Return the actual day'
                                        exp = '09'
                                        act = actual_day_act ).

  ENDMETHOD.

ENDCLASS.
