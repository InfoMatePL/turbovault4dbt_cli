{{ config(schema='rdv', materialized='view') }} 

{%- set yaml_metadata -%}
sat_v0: 'masat30'
hashkey: 'hpk_hub3'
hashdiff: 'hd_masat3' 
ma_attribute: 
  - multiattr_masat3
  - multiattr2_masat3

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