{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'SRC1': 'hub2'
hashed_columns:
  target_role_pk_hub2:
    - scol_hub2
  target_pk_hub2:
    - scol_hub2
  hpk_hub2:
    - pta_hub2
  hd_sat_hub2:
    is_hashdiff: true
    columns:
      - scol_hub2
  hd_masat_hub2:
    is_hashdiff: true
    columns:
      - scol_hub2
  hd_nhsat_hub2:
    is_hashdiff: true
    columns:
      - scol_hub2


multiactive_config:
  multi_active_key:
  - multiattr_hub2
  - multiattr2_hub2
  main_hashkey_column:
  - hpk_hub2
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