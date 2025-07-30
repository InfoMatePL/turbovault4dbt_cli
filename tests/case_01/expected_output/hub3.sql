{{ config(schema='rdv',
    materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_hub3
    bk_columns: 'scol_hub3'
    hk_column: target_pk_hub3
    rsrc_static: 'static_rsrc_hub3'
hashkey: target_pk_hub3
business_keys: 
  - 'bk_hub3'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.hub(hashkey=metadata_dict.get("hashkey"),
        business_keys=metadata_dict.get("business_keys"),
        source_models=metadata_dict.get("source_models")) }}
