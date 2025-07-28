{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['hpk_hub3', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_hub3" 
parent_hashkey: "hpk_hub3"
src_hashdiff: 'hd_sat_hub3'
src_payload: 
  - target_col_hub3

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}