CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_integr_test_table.
    METHODS:
      setup,
      get_data FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

    test-INJECTION is_test.
      g_is_test = |X|.
    end-test-INJECTION.

  ENDMETHOD.

  METHOD get_data.

    f_cut = NEW #( ).

    DELETE FROM zunitdemo_table1 WHERE test = 'X'.
    DATA: new_data TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.
    new_data = VALUE #( ( test = |X|
                          key_a = |A|
                          field_1 = |C| ) ).

    INSERT zunitdemo_table1 FROM TABLE new_data.
    COMMIT WORK. " Required in case the data shall really be stored or deleted

    DATA: read_data_act TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY,
          read_data_exp TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.

    read_data_act = f_cut->get_data( ).

    read_data_exp = VALUE #( (
                          mandt = sy-mandt
                          test = |X|
                          key_a = |A|
                          field_1 = |C| ) ).

   cl_abap_unit_assert=>assert_equals( msg = 'Expect correct data' exp = read_data_exp act = read_data_act ).

  ENDMETHOD.

ENDCLASS.
