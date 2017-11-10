CLASS ltcl_robust DEFINITION DEFERRED.
CLASS zunitdemo_robust_seam DEFINITION LOCAL FRIENDS ltcl_robust. "Allow tests of local classes
CLASS ltcl_robust DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_robust_seam.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_robust IMPLEMENTATION.

  METHOD first_test.

    TEST-INJECTION scarr.

      CASE carrid.
        WHEN 'LH'.
          line = VALUE #( carrid = |LH| carrname = |Lufthansa| ).
          sy-subrc = 0.
        WHEN OTHERS.
          CLEAR line.
          sy-subrc = 4.
      ENDCASE.

    END-TEST-INJECTION.

    f_cut = NEW #( ).

    DATA: carrname_act TYPE s_carrname.

    f_cut->_get_airline_name( EXPORTING carrid = 'LH'
                              IMPORTING carrname = carrname_act ).

    cl_abap_unit_assert=>assert_equals( msg = 'Lufthansa is the name of LH'
                                        exp = |Lufthansa|
                                        act = carrname_act ).

  ENDMETHOD.

ENDCLASS.
