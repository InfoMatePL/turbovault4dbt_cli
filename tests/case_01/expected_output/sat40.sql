{{ config(schema='rdv',
           materialized='incremental',
           unique_key=['hpk_hub4', 'ldts']) }} 

{%- set yaml_metadata -%}
source_model: "stg_sat4" 
parent_hashkey: "hpk_hub4"
src_hashdiff: 'hd_sat4'
src_payload: 
  - target_col_sat4

{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.sat_v0(parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        source_model=metadata_dict.get('source_model'),
                        src_payload=metadata_dict.get('src_payload')) }}