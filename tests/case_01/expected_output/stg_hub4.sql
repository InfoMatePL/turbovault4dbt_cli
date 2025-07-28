{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'SRC1': 'hub4'
hashed_columns:
  target_role_pk_hub4:
    - scol_hub4
  target_pk_hub4:
    - scol_hub4
  hpk_hub4:
    - pta_hub4
  hd_sat_hub4:
    is_hashdiff: true
    columns:
      - scol_hub4
  hd_masat_hub4:
    is_hashdiff: true
    columns:
      - scol_hub4
  hd_nhsat_hub4:
    is_hashdiff: true
    columns:
      - scol_hub4


multiactive_config:
  multi_active_key:
  - multiattr_hub4
  - multiattr2_hub4
  main_hashkey_column:
  - hpk_hub4
rsrc: 'rsrc' 
ldts: 'ldts'
include_source_columns: true

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.stage(source_model=metadata_dict.get('source_model'),
                        ldts=metadata_dict.get('ldts'),
                        rsrc=metadata_dict.get('rsrc'),
                        hashed_columns=metadata_dict.get('hashed_columns'),
                        derived_columns=metadata_dict.get('derived_columns'),
                        prejoined_columns=metadata_dict.get('prejoined_columns'),
                        missing_columns=metadata_dict.get('missing_columns')) }}