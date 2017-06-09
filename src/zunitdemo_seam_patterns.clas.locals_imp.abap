CLASS test_container DEFINITION FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      result TYPE i.
ENDCLASS.

CLASS test_for_execution DEFINITION FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      is_executed TYPE abap_bool.
ENDCLASS.
