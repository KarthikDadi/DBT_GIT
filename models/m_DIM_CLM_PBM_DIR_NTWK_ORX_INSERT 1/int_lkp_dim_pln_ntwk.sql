-- int_lkp_dim_pln_ntwk.sql
{{ config(materialized='table', tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]) }}

with lkp_dim_clm_pbm_ntwk as (
    -- no sql override, using the lookup table directly
    select
        ntwk_desc
    from {{ source('gnp2data', 'dim_clm_pbm_ntwk') }}
),

trans_exp_landling_zone as (
    -- referencing upstream transformation
    select
        ntwk_desc,
        crt_tmsp,
        dummyjoin
    from {{ ref('trans_exp_landling_zone') }}
),

int_lkp_dim_pln_ntwk as (
    -- performing the connected lookup
    select
        b.ntwk_desc as ntwk_desc,
        a.ntwk_desc as ntwk_desc1,
        a.crt_tmsp as crt_tmsp1,
        a.dummyjoin as dummyjoin
    from trans_exp_landling_zone as a
    left join lkp_dim_clm_pbm_ntwk as b
        on a.ntwk_desc = b.ntwk_desc
)

-- final selection to match informatica output ports order
select
    ntwk_desc,
    ntwk_desc1,
    crt_tmsp1,
    dummyjoin
from int_lkp_dim_pln_ntwk