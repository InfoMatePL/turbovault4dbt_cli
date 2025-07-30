{{ config(schema='rdv',
           materialized='view') }} 

{%- set yaml_metadata -%}
sat_v0: 'sat0_hub4'
hashkey: "hpk_hub4"
hashdiff: 'hd_sat_hub4'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.sat_v1(sat_v0=metadata_dict.get('sat_v0'),
    hashkey=metadata_dict.get('hashkey'),
    hashdiff=metadata_dict.get('hashdiff'),
    ledts_alias=metadata_dict.get('ledts_alias'),
    add_is_current_flag=true) }}