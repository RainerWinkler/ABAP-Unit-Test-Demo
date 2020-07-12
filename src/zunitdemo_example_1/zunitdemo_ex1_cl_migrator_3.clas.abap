class ZUNITDEMO_EX1_CL_MIGRATOR_3 definition
  public
  create public .

public section.

  types:
    ty_carrid TYPE RANGE OF sflight-carrid .

  methods MIGRATE
    importing
      !CARRID_RANGE type TY_CARRID .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZUNITDEMO_EX1_CL_MIGRATOR_3 IMPLEMENTATION.


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
