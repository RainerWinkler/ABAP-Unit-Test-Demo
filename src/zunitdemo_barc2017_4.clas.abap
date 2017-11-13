CLASS zunitdemo_barc2017_4 DEFINITION
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



CLASS zunitdemo_barc2017_4 IMPLEMENTATION.

  METHOD actual_day.
    test-SEAM sy_datum.
    r_result = sy-datum.
    end-test-SEAM.
  ENDMETHOD.

ENDCLASS.
