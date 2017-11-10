CLASS zunitdemo_barc2017_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS actual_date
      RETURNING
        VALUE(r_result) TYPE d.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_barc2017_2 IMPLEMENTATION.


  METHOD actual_date.
    TEST-SEAM sy_datum.
      r_result = sy-datum.
    END-TEST-SEAM.
  ENDMETHOD.
ENDCLASS.
