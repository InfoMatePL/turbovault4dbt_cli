{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_hub2
    fk_columns: 'target_col_hub2'
    rsrc_static: 'static_rsrc_hub2'
link_hashkey: target_pk_hub2 
foreign_hashkeys: 
  - 'target_col_hub2'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.link(link_hashkey=metadata_dict.get("link_hashkey"),
        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
        source_models=metadata_dict.get("source_models")) }}