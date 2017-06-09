CLASS ltcl_assign_from_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_seam_patterns.
    METHODS:
      insert FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_assign_from_test IMPLEMENTATION.

  METHOD insert.

    " This works:

    TEST-INJECTION insert.

      a = 10.

    END-TEST-INJECTION.

    " Variables from the unit test can not be injected
    " But a static public attribute from a local class (for testing) can be assigned

    test_container=>result = 10.

    TEST-INJECTION insert.

      a = test_container=>result.

    END-TEST-INJECTION.

    " TEST-INJECTIONS can be repeated, each time the coding is replaced

    " This does not work:

*    data test_data TYPE i.
*
*    test_data = 10.
*
*    TEST-INJECTION insert.
*
*      a = test_data.
*
*    END-TEST-INJECTION.


    f_cut = NEW #( ).

    DATA result_act TYPE i.

    result_act = f_cut->assign_from_test( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Result is changed in test'
                                        exp = 10
                                        act = result_act ).

    test_for_execution=>is_executed = abap_false.

    TEST-INJECTION code_snippet.
      test_for_execution=>is_executed = abap_true.
    END-TEST-INJECTION.

    cl_abap_unit_assert=>assert_equals( msg = 'Code Snippet has to be executed'
                                        exp = abap_true
                                        act = test_for_execution=>is_executed ).

  ENDMETHOD.

ENDCLASS.
