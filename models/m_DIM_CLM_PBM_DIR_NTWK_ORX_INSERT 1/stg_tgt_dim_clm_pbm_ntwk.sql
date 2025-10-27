-- stg_tgt_dim_clm_pbm_ntwk.sql
{{
    config(
        materialized='incremental',
        tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]
    )
}}

with trans_exp_define_ntwk_id as (
    select
        ntwk_id,
        ntwk_desc,
        crt_tmsp
    from {{ ref('trans_exp_define_ntwk_id') }}
),

stg_tgt_dim_clm_pbm_ntwk as (
    select
        ntwk_id,
        ntwk_desc,
        crt_tmsp,
        cast(null as varchar(100)) as upd_user,
        cast(null as varchar(150)) as src_ntwk_desc
    from trans_exp_define_ntwk_id
)

select * from stg_tgt_dim_clm_pbm_ntwk