CLASS ltcl_test DEFINITION DEFERRED.
CLASS zunitdemo_robust_seam2 DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zunitdemo_robust_seam2.
    METHODS:
      setup,
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

    TEST-INJECTION scarr.
      cl_abap_unit_assert=>fail( msg = 'Redefine me' ).
    END-TEST-INJECTION.

  ENDMETHOD.

  METHOD first_test.

    DATA: carrid       TYPE s_carr_id,
          carrname_act TYPE s_carrname.

    carrid = |LH|.

    f_cut = NEW #( ).

    TEST-INJECTION scarr.

      IF carrid EQ 'LH'.

        carrnam = |Lufthansa|.
        sy-subrc = 0.

      ELSE.

        CLEAR carrnam.
        sy-subrc = 4.

      ENDIF.

    END-TEST-INJECTION.

    f_cut->_get_airline_name( EXPORTING carrid = carrid
                              IMPORTING carrnam = carrname_act ).

    cl_abap_unit_assert=>assert_equals( msg = 'Get the correct name of the carrier'
                                        exp = |Lufthansa|
                                        act = carrname_act ).

  ENDMETHOD.

ENDCLASS.
