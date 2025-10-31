-- int_jnr_dummyjoin
{{ config(materialized='table', tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]) }}

with fil_new_records as (
    select * from {{ ref('int_fil_new_records') }}
),
exp_landling_zone1 as (
    select * from {{ ref('trans_exp_landling_zone1') }}
),
jnr_dummyjoin as (
    select
        fil_new_records.ntwk_desc1,
        fil_new_records.crt_tmsp1,
        fil_new_records.dummyjoin as dummy_join,
        exp_landling_zone1.dummy_join as dummy_join1,
        exp_landling_zone1.max_ntwk_id
    from fil_new_records
    inner join exp_landling_zone1
        on fil_new_records.dummyjoin = exp_landling_zone1.dummy_join
)
select
    ntwk_desc1,
    crt_tmsp1,
    dummy_join,
    dummy_join1,
    max_ntwk_id
from jnr_dummyjoin