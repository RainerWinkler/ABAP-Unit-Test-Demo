CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut2         TYPE REF TO zunitdemo_table_no_mock,
          read_data2_act TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY,
          read_data2_exp TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.
    METHODS:
      setup,
      _prepare_test_data
        IMPORTING
          key   TYPE string
          field TYPE string,
      _test
        IMPORTING
          message TYPE string,
      get_data FOR TESTING RAISING cx_static_check,
      get_data2 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

    TEST-INJECTION is_test.
      g_is_test = |X|.
    END-TEST-INJECTION.

    f_cut2 = NEW #( ).

  ENDMETHOD.

  METHOD get_data.

    f_cut2 = NEW #( ).

    DELETE FROM zunitdemo_table1 WHERE test = 'X'.
    DATA: new_data TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.
    new_data = VALUE #( ( test = |X|
                          key_a = |A|
                          field_1 = |C| ) ).

    INSERT zunitdemo_table1 FROM TABLE new_data.
    COMMIT WORK. " Required in case the data shall really be stored or deleted

    DATA: read_data_act TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY,
          read_data_exp TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.

    read_data_act = f_cut2->get_data( ).

    read_data_exp = VALUE #( (
                          mandt = sy-mandt
                          test = |X|
                          key_a = |A|
                          field_1 = |C| ) ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expect correct data' exp = read_data_exp act = read_data_act ).

  ENDMETHOD.

  METHOD get_data2.

    " Version of test method get_data which is easier to read

    _prepare_test_data( key = |A| field = |C| ).

    read_data2_exp = VALUE #( ( mandt = sy-mandt
                                test = |X|
                                key_a = |A|
                                field_1 = |C| ) ).

    _test( message = |Expect correct data| ).

  ENDMETHOD.


  METHOD _prepare_test_data.




    " Prepare test data

    DELETE FROM zunitdemo_table1 WHERE test = 'X'.
    DATA: new_data TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.
    new_data = VALUE #( ( test = |X|
                          key_a = |{ key }|
                          field_1 = |{ field }| ) ).

    INSERT zunitdemo_table1 FROM TABLE new_data.
    COMMIT WORK. " Required in case the data shall really be stored or deleted

  ENDMETHOD.


  METHOD _test.

    " Test
    read_data2_act = f_cut2->get_data( ).

    cl_abap_unit_assert=>assert_equals( msg = message exp = read_data2_exp act = read_data2_act ).

  ENDMETHOD.

ENDCLASS.
