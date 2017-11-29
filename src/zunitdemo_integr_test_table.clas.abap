CLASS zunitdemo_integr_test_table DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_table TYPE STANDARD TABLE OF zunitdemo_table1 WITH DEFAULT KEY.
    METHODS:
      constructor,
      get_data
        RETURNING
          VALUE(r_result) TYPE ty_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA g_is_test TYPE abap_bool.
ENDCLASS.



CLASS ZUNITDEMO_INTEGR_TEST_TABLE IMPLEMENTATION.


  METHOD constructor.

    TEST-SEAM is_test.
    END-TEST-SEAM.

  ENDMETHOD.


  METHOD get_data.
    " This method is tested with an integration test.
    " Here the table has a name range that is exclusively used for unit tests.
    " The flag g_is_test is set during tests in the constructor with a test seam.
    SELECT * FROM zunitdemo_table1 INTO TABLE r_result WHERE
      test = g_is_test.

  ENDMETHOD.
ENDCLASS.
