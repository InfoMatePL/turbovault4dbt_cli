{{ config(materialized='view') }}
{{ config(schema='stg') }}

{%- set yaml_metadata -%}
source_model: 
  'SRC1': 'link3'
hashed_columns:
  target_pk_link3:
    - scol_link3
  hpk_hub3:
    - pta_link3



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