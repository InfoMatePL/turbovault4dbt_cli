{{ config(schema='rdv',
          materialized='incremental') }}

{%- set yaml_metadata -%}
source_models: 
  - name: stg_hub3
    fk_columns: 'target_col_hub3'
    rsrc_static: 'static_rsrc_hub3'
link_hashkey: target_pk_hub3 
foreign_hashkeys: 
  - 'target_col_hub3'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ datavault4dbt.link(link_hashkey=metadata_dict.get("link_hashkey"),
        foreign_hashkeys=metadata_dict.get("foreign_hashkeys"),
        source_models=metadata_dict.get("source_models")) }}