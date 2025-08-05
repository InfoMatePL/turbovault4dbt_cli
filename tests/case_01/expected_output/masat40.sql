{{ config(schema='rdv',
           materialized='incremental') }} 

{%- set yaml_metadata -%}
source_model: "stg_masat4" 
parent_hashkey: "hpk_hub4"
src_hashdiff: "hd_masat4"
src_ma_key: 
  - multiattr_masat4
  - multiattr2_masat4

src_payload: 
  - target_col_masat4

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{ datavault4dbt.ma_sat_v0(source_model=metadata_dict.get('source_model'),
                        parent_hashkey=metadata_dict.get('parent_hashkey'),
                        src_hashdiff=metadata_dict.get('src_hashdiff'),
                        src_ma_key=metadata_dict.get('src_ma_key'),
                        src_payload=metadata_dict.get('src_payload')) }}