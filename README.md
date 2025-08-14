# sap-abap-inventory-stock-monitoring-report
ABAP report to monitor inventory stock using standard SAP tables and ALV display (CL_SALV_TABLE). Includes selection filters for material, plant, and storage location.
-Selection screen with filters:
- Material Number(s)
- Plant(s)
- Storage Location(s)
- Joins multiple SAP standard tables (`MARA`, `MAKT`, `MARC`, `MARD`)
- Displays data using `CL_SALV_TABLE` (Simple ALV)
- Includes exception handling using `TRY...CATCH`
- Easy-to-read and extendable ABAP code

## Tables Used 

| Table  | Description                            |
|------- |----------------------------------------|
| `MARA` | General Material Data                  |
| `MAKT` | Material Descriptions (`SPRAS = 'E'`)  |
| `MARC` | Plant-specific Material Data           |
| `MARD` | Storage Location Stock                 |
