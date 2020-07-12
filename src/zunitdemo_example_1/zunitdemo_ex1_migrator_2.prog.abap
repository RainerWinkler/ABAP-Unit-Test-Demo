REPORT zunitdemo_ex1_migrator_2.

TABLES sflight.

" Correct prices in SFLIGHT
" See also program documentation
" Assume that amount of data is so small, that it can be changed in a single commit

SELECT-OPTIONS s_carr FOR sflight-carrid.
PARAMETERS: p_code TYPE n LENGTH 4.

START-OF-SELECTION.

  IF p_code <> '4752'.
    WRITE: / 'Wrong code, nothing will be done'.
    RETURN.
  ENDIF.


  DATA: migrator TYPE REF TO zunitdemo_ex1_cl_migrator_2.
  migrator = NEW #( ).

  " Copy select table to range with is transferred to the class

  DATA carrid_range TYPE migrator->ty_carrid.
  LOOP AT s_carr INTO DATA(sc).
    APPEND sc TO carrid_range.
  ENDLOOP.

  migrator->migrate( EXPORTING carrid_range = carrid_range ).
