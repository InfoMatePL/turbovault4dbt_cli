{{ config(schema='rdv',
           materialized='incremental') }} 

{%- set yaml_metadata -%}
source_model: "stg_masat3" 
parent_hashkey: "hpk_hub3"
src_hashdiff: "hd_masat3"
src_ma_key: 
  - multiattr_masat3
  - multiattr2_masat3

src_payload: 
  - target_col_masat3

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.ma_sat_v0(source_model=metadata_dict.get('source_model'),
                        parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        src_ma_key=metadata_dict.get('src_ma_key'),
                        src_payload=metadata_dict.get('src_payload')) }}