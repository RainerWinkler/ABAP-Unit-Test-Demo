class ZUNITDEMO_SIMPLE_ACTDATE definition
  public
  create public .

public section.

  methods GET_DATE
    returning
      value(ACTUAL_DAY) type D .
protected section.
private section.
ENDCLASS.



CLASS ZUNITDEMO_SIMPLE_ACTDATE IMPLEMENTATION.


  method GET_DATE.

    actual_day = sy-datum.

  endmethod.
ENDCLASS.
