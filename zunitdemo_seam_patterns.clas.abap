CLASS zunitdemo_seam_patterns DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! Demonstration how information is transported from the test code to the tested method
    METHODS assign_from_test
      RETURNING
        VALUE(result) TYPE i .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_seam_patterns IMPLEMENTATION.


  METHOD assign_from_test.

    DATA: a TYPE i.

    TEST-SEAM insert.

      a = 2.

    END-TEST-SEAM.

    " The container is a local class of type testing, it cannot be referenced here
    " test_container=>result = 20.

    result = a.

  ENDMETHOD.
ENDCLASS.
