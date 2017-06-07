CLASS zunitdemo_robust_seam2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _get_airline_name
      IMPORTING
        carrid  TYPE s_carr_id
      EXPORTING
        carrnam TYPE s_carrname.
ENDCLASS.



CLASS zunitdemo_robust_seam2 IMPLEMENTATION.

  METHOD _get_airline_name.

    TEST-SEAM scarr.

      SELECT SINGLE carrname FROM scarr INTO carrnam WHERE carrid = carrid.

    END-TEST-SEAM.

  ENDMETHOD.

ENDCLASS.
