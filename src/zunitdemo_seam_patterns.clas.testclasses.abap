CLASS ltcl_assign_from_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    data: f_cut TYPE REF TO zunitdemo_seam_patterns.
    METHODS:
      insert FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_assign_from_test IMPLEMENTATION.

  METHOD insert.
    test_container=>result = 10.
    TEST-INJECTION insert.

      a = test_container=>result.

    END-TEST-INJECTION.

    f_cut = new #( ).

    data result_act TYPE i.

    result_act = f_cut->assign_from_test( ).

    cl_abap_unit_assert=>assert_equals( msg = 'Result is changed in test'
                                        exp = 10
                                        act = result_act ).

  ENDMETHOD.

ENDCLASS.
