CLASS zunitdemo_ex1_cl_migrator_2 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      ty_carrid TYPE RANGE OF sflight-carrid .
    METHODS migrate
      IMPORTING
        !carrid_range TYPE ty_carrid .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zunitdemo_ex1_cl_migrator_2 IMPLEMENTATION.


  METHOD migrate.

    DATA: modified  TYPE sflight,
          modifieds TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.

    SELECT * FROM sflight INTO TABLE @DATA(sfs) WHERE carrid IN @carrid_range.

    LOOP AT sfs INTO DATA(sf).
      IF sf-fldate EQ '20200101'.
        IF sf-price IS NOT INITIAL.
          modified = sf.
          IF sf-price < 100.
            ADD 1 TO modified-price.
          ELSEIF sf-price < 1000.
            ADD 10 TO modified-price.
          ELSE.
            ADD 20 TO modified-price.
          ENDIF.
          modifieds = VALUE #( BASE modifieds ( modified ) ).
        ENDIF.
      ENDIF.

    ENDLOOP.

    IF modifieds IS NOT INITIAL.
      MODIFY sflight FROM TABLE modifieds.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
