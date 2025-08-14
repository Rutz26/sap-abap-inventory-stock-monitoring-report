REPORT z_inventory_stock_monitor.

TABLES: mara, makt, marc, mard.

TYPES: BEGIN OF ty_stock,
         matnr TYPE mara-matnr,
         matkx TYPE makt-maktx,
         werks TYPE marc-werks,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
         meins TYPE mara-meins,
       END OF ty_stock.

DATA: it_stock TYPE TABLE OF ty_stock,
      wa_stock TYPE ty_stock.

SELECT-OPTIONS: s_matnr FOR mara-matnr,
                s_werks FOR marc-werks,
                s_lgort FOR mard-lgort.

START-OF-SELECTION.

  SELECT a~matnr
         b~maktx
         c~werks
         d~lgort
         d~labst
         a~meins
    FROM mara AS a
    INNER JOIN makt AS b ON a~matnr = b~matnr
    INNER JOIN marc AS c ON a~matnr = c~matnr
    INNER JOIN mard AS d ON a~matnr = d~matnr AND c~werks = d~werks
    INTO TABLE it_stock
    WHERE a~matnr IN s_matnr
      AND c~werks IN s_werks
      AND d~lgort IN s_lgort
      AND b~spras = 'E'.

  IF sy-subrc = 0.
    PERFORM display_alv.
  ELSE.
    WRITE: / 'No data found for selection.'.
  ENDIF.

*---------------------------------------------------------------------*
*       FORM display_alv                                             *
*---------------------------------------------------------------------*
FORM display_alv.
  DATA: lo_alv  TYPE REF TO cl_salv_table,
        lo_cols TYPE REF TO cl_salv_columns_table,
        lo_col  TYPE REF TO cl_salv_column_table,
        lx_msg  TYPE REF TO cx_salv_msg. " Pre-declared exception

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = it_stock ).

      lo_cols = lo_alv->get_columns( ).
      lo_alv->display( ).


 CATCH cx_salv_msg INTO lx_msg.
  WRITE: / 'An error occurred while displaying ALV.'.

ENDTRY.

ENDFORM.