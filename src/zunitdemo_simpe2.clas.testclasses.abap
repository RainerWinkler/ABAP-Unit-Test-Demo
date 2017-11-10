CLASS ltcl_simple DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    data: f_cut TYPE REF TO zunitdemo_simpe2.
    METHODS:
      simple FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_simple IMPLEMENTATION.

  METHOD simple.

    f_cut = new #( ).

    data: day TYPE numc2.

    test-INJECTION sy_datum.

     date = '20170607'.

    end-TEST-INJECTION.

    day = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Get the day of the actual date'
                                        exp = '07'
                                        act = day ).

  ENDMETHOD.

ENDCLASS.
