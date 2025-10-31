-- trans_exp_landling_zone1.sql
{{ config(materialized='table', tags=["m_DIM_CLM_PBM_DIR_NTWK_ORX_INSERT"]) }}

with stg_sq_gnp2_lib_dim_clm_pbm_ntwk as (
    select * from {{ ref('stg_sq_gnp2_lib_dim_clm_pbm_ntwk') }}
),

trans_exp_landling_zone1 as (
    select
        ntwk_id as max_ntwk_id,
        1 as dummy_join
    from stg_sq_gnp2_lib_dim_clm_pbm_ntwk
)

select * from trans_exp_landling_zone1