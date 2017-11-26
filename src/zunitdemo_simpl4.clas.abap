CLASS zunitdemo_simpl4 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_actual_day
      RETURNING
        VALUE(r_result) TYPE numc2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_simpl4 IMPLEMENTATION.


  METHOD get_actual_day.

    DATA: date TYPE sy-datum.

          " Test 002

    TEST-SEAM sy_datum.

      date = sy-datum.

    END-TEST-SEAM.

    r_result = date+6(2).

  ENDMETHOD.
ENDCLASS.
