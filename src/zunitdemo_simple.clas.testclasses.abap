CLASS ltcl_demo DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_simple.
    METHODS:
      test_with_test_injections FOR TESTING RAISING cx_static_check,
      test_with_test_parameters FOR TESTING RAISING cx_static_check,
      test_with_mock_class FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_demo IMPLEMENTATION.

  METHOD test_with_test_injections.

    TEST-INJECTION sy_datum.

      date = '20170102'.

    END-TEST-INJECTION.

    f_cut = NEW #( ).

    DATA: day_act TYPE n LENGTH 2.

    day_act = f_cut->actual_day( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Today is the second day of the month'
                                        exp = '02'
                                        act = day_act ).

  ENDMETHOD.

  METHOD test_with_test_parameters.

    f_cut = NEW #( date_for_test = '20170102' ).

    DATA: day_act TYPE n LENGTH 2.

    day_act = f_cut->actual_day2( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Today is the second day of the month'
                                        exp = '02'
                                        act = day_act ).

  ENDMETHOD.

  METHOD test_with_mock_class.

    DATA: day_provider TYPE REF TO zunitdemo_simple_actdate_mock.

    day_provider = NEW #( test_day = '20170102' ).

    f_cut = NEW #( actdate_provider = day_provider ).

    DATA: day_act TYPE n LENGTH 2.

    day_act = f_cut->actual_day3( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Today is the second day of the month'
                                        exp = '02'
                                        act = day_act ).

  ENDMETHOD.

ENDCLASS.
