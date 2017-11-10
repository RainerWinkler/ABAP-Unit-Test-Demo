CLASS zunitdemo_simpe2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS actual_day
      RETURNING
        VALUE(r_result) TYPE numc2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_simpe2 IMPLEMENTATION.


  METHOD actual_day.

    DATA: date TYPE sy-datum.

    TEST-SEAM sy_datum.

      date = sy-datum.

    END-TEST-SEAM.

    r_result = date+6(2).

  ENDMETHOD.
ENDCLASS.
