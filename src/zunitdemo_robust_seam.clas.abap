CLASS zunitdemo_robust_seam DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _get_airline_name
      IMPORTING
        carrid   TYPE s_carr_id
      EXPORTING
        carrname TYPE s_carrname.
ENDCLASS.



CLASS zunitdemo_robust_seam IMPLEMENTATION.

  METHOD _get_airline_name.

    TEST-SEAM scarr.

      SELECT SINGLE * FROM scarr INTO @DATA(line) WHERE carrid = @carrid.

    END-TEST-SEAM.

    carrname = line-carrname.

  ENDMETHOD.

ENDCLASS.
