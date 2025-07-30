{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_hub2
    bk_columns: 'scol_hub2'
    hk_column: target_pk_hub2
    rsrc_static: 'static_rsrc_hub2'
hashkey: target_pk_hub2
business_keys: 
  - 'bk_hub2'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
