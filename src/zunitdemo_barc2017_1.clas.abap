CLASS zunitdemo_barc2017_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS method1
      RETURNING
        VALUE(r_result) TYPE d.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_barc2017_1 IMPLEMENTATION.

  METHOD method1.
    " Test Comment
    TEST-SEAM sy_datum.
      r_result = sy-datum.
    END-TEST-SEAM.
  ENDMETHOD.

ENDCLASS.
