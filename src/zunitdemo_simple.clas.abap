CLASS zunitdemo_simple DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! Returns the day of the actual date
    METHODS actual_day
      RETURNING
        VALUE(r_result) TYPE numc2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_simple IMPLEMENTATION.


  METHOD actual_day.

    TEST-SEAM sy_datum.

      DATA(date) = sy-datum.

    END-TEST-SEAM.

    r_result = date+6(2).

  ENDMETHOD.
ENDCLASS.
