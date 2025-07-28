{{ config(schema='rdv', materialized='view') }} 

{%- set yaml_metadata -%}
sat_v0: 'masat0_hub2'
hashkey: 'hpk_hub2'
hashdiff: 'hd_masat_hub2' 
ma_attribute: 
  - multiattr_hub2
  - multiattr2_hub2

ledts_alias: 'valid_to'
add_is_current_flag: true
{%- endset -%}    

{%- set metadata_dict = fromyaml(yaml_metadata) -%}


{{ datavault4dbt.ma_sat_v1(sat_v0=metadata_dict.get("sat_v0"),
                        hashkey=metadata_dict.get("hashkey"),
                        hashdiff=metadata_dict.get("hashdiff"),
                        ma_attribute=metadata_dict.get("ma_attribute"),
                        ledts_alias=metadata_dict.get("ledts_alias"),
                        add_is_current_flag=metadata_dict.get("add_is_current_flag")) }}