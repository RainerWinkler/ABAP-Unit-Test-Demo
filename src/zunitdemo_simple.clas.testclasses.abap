CLASS ltcl_demo DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_simple.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_demo IMPLEMENTATION.

  METHOD first_test.

    TEST-INJECTION sy_datum.

      date = '20170102'.

    END-TEST-INJECTION.

    f_cut = NEW #( ).

    DATA: day_act TYPE n LENGTH 2.

    day_act = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Today is the second day of the month' exp = '02' act = day_act ).

  ENDMETHOD.

ENDCLASS.
