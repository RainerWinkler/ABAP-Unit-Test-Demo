CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_simpl4 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_simpl4.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD first_test.

    f_cut = NEW #( ).

    DATA: day_act TYPE numc2.

    TEST-INJECTION sy_datum.

      date = '20170610'.

    END-TEST-INJECTION.

    day_act = f_cut->get_actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Der Tag sollte 10 sein' exp = '10' act = day_act ).



  ENDMETHOD.

ENDCLASS.
