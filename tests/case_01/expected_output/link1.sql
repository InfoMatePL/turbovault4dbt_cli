{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_link1
    fk_columns: 'target_col_link1'
    rsrc_static: 'static_rsrc_link1'
link_hashkey: target_pk_link1 
foreign_hashkeys: 
  - 'target_col_link1'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.link(link_hashkey=metadata_dict.get("link_hashkey"),
        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
        source_models=metadata_dict.get("source_models")) }}