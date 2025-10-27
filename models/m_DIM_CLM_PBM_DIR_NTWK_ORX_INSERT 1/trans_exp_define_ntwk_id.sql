-- trans_exp_define_ntwk_id.sql
{{ config(materialized='table', tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]) }}

with int_srt_ntwk_desc as (
    select
        ntwk_desc1 as ntwk_desc,
        max_ntwk_id,
        crt_tmsp1 as crt_tmsp
    from {{ ref('int_srt_ntwk_desc') }}
),

trans_exp_define_ntwk_id as (
    select
        ntwk_desc,
        max_ntwk_id,
        crt_tmsp,
        -- port: v_ntwk_id
        dense_rank() over (order by ntwk_desc) as v_ntwk_id
    from int_srt_ntwk_desc
)

select
    -- port: ntwk_desc
    ntwk_desc,
    -- port: crt_tmsp
    crt_tmsp,
    -- port: ntwk_id
    v_ntwk_id + max_ntwk_id as ntwk_id
from trans_exp_define_ntwk_id