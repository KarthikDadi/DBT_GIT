-- transformation_name: SRT_NTWK_DESC
{{
  config(
    materialized="view",
    tags=["m_DIM_CLM_PBM_DIR_NTWK_ORX_INSERT"]
  )
}}

with source_data as (
  select
    ntwk_desc1,
    crt_tmsp1,
    max_ntwk_id
  from {{ ref('int_jnr_dummyjoin') }}
)

select
  ntwk_desc1,
  crt_tmsp1,
  max_ntwk_id
from source_data
order by ntwk_desc1 asc