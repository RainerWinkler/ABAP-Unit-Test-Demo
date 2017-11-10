CLASS zunitdemo_simple_actdate_mock DEFINITION
  PUBLIC
  INHERITING FROM zunitdemo_simple_actdate
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        test_day TYPE d.
    METHODS get_date
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA g_test_day TYPE d.
ENDCLASS.



CLASS ZUNITDEMO_SIMPLE_ACTDATE_MOCK IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
    g_test_day = test_day.
  ENDMETHOD.


  METHOD get_date.
    actual_day = g_test_day.
  ENDMETHOD.
ENDCLASS.
