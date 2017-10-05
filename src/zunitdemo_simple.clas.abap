CLASS zunitdemo_simple DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        date_for_test TYPE d OPTIONAL.
    "! Returns the day of the actual date
    METHODS actual_day
      RETURNING
        VALUE(r_result) TYPE numc2.
    METHODS actual_day2
      RETURNING
        VALUE(r_result) TYPE numc2.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA g_date_for_test TYPE d.
ENDCLASS.



CLASS zunitdemo_simple IMPLEMENTATION.


  METHOD actual_day.

    " To be tested with test seams

    TEST-SEAM sy_datum.

      DATA(date) = sy-datum.

    END-TEST-SEAM.

    r_result = date+6(2).

  ENDMETHOD.
  METHOD constructor.
    g_date_for_test = date_for_test.
  ENDMETHOD.

  METHOD actual_day2.

    " Use a global parameter to enable unit testing

    IF g_date_for_test IS INITIAL.
      DATA(date) = g_date_for_test.
    ELSE.
      date = sy-datum.
    ENDIF.

    r_result = date+6(2).

  ENDMETHOD.

ENDCLASS.
