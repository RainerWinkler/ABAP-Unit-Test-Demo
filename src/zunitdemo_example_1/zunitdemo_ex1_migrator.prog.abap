REPORT zunitdemo_ex1_migrator.

TABLES sflight.

" Correct prices in SFLIGHT
" See also program documentation
" Assume that amount of data is so small, that it can be changed in a single commit

PARAMETERS: p_code TYPE n LENGTH 4.

IF p_code <> '4752'.
  WRITE: / 'Wrong code, nothing will be done'.
  RETURN.
ENDIF.

DATA: modified  TYPE sflight,
      modifieds TYPE STANDARD TABLE OF sflight WITH DEFAULT KEY.

SELECT * FROM sflight INTO TABLE @DATA(sfs).

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
