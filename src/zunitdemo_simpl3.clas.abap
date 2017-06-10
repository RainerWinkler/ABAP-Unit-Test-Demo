CLASS zunitdemo_simpl3 DEFINITION
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



CLASS zunitdemo_simpl3 IMPLEMENTATION.


  METHOD actual_day.

    DATA: actual_date TYPE sy-datum.

    TEST-SEAM sy_datum.

      actual_date = sy-datum.

    END-TEST-SEAM.

    r_result = actual_date+6(2).

  ENDMETHOD.
ENDCLASS.
