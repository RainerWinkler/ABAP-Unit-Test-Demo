CLASS zunitdemo_barc2017_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS actual_day
      RETURNING
        VALUE(r_result) TYPE d.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_barc2017_3 IMPLEMENTATION.

  METHOD actual_day.
    TEST-SEAM sy_datum.
      r_result = sy-datum.
    END-TEST-SEAM.
  ENDMETHOD.

ENDCLASS.
