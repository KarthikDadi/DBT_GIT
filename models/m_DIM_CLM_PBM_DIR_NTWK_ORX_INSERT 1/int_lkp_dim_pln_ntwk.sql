-- int_lkp_dim_pln_ntwk.sql
{{ config(materialized='table', tags=["m_DIM_CLM_PBM_DIR_NTWK_ORX_INSERT"]) }}

with lkp_src_dim_clm_pbm_ntwk as (
    select
        ntwk_desc
    from {{ source('gnp2data', 'dim_clm_pbm_ntwk') }}
),

trans_exp_landling_zone as (
    select
        ntwk_desc,
        crt_tmsp,
        dummyjoin
    from {{ ref('trans_exp_landling_zone') }}
),

int_lkp_dim_pln_ntwk as (
    select
        b.ntwk_desc as ntwk_desc,
        a.ntwk_desc as ntwk_desc1,
        a.crt_tmsp as crt_tmsp1,
        a.dummyjoin as dummyjoin
    from trans_exp_landling_zone as a
    left join lkp_src_dim_clm_pbm_ntwk as b
        on a.ntwk_desc = b.ntwk_desc
)

select
    ntwk_desc,
    ntwk_desc1,
    crt_tmsp1,
    dummyjoin
from int_lkp_dim_pln_ntwk