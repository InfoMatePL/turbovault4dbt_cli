{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['hpk_hub2', 'ldts']) }} 

{%- set yaml_metadata -%}
parent_hashkey: "hpk_hub2"
src_payload:
  - target_col_hub2

source_model: "stg_hub2" 
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.nh_sat(parent_hashkey=metadata_dict.get("parent_hashkey"),
                src_payload=metadata_dict.get("src_payload"),
                source_model=metadata_dict.get("source_model"))   }}