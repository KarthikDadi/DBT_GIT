-- FIL_NEW_RECORDS
{{ config(
  materialized='table',
  tags=["m_DIM_CLM_PBM_DIR_NTWK_ORX_INSERT"]
) }}

with int_lkp_dim_pln_ntwk as (
    select * from {{ ref('int_lkp_dim_pln_ntwk') }}
),

fil_new_records as (
    select *
    from int_lkp_dim_pln_ntwk
    where ntwk_desc is null
)

select
    ntwk_desc1,
    crt_tmsp1,
    dummyjoin
from fil_new_records