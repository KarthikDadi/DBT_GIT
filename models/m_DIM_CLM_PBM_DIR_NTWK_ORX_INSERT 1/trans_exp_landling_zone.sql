-- trans_exp_landling_zone.sql
{{ config(
    materialized='table',
    tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]
) }}

with stg_sq_gnp2_lib_ods_dir_orx_trans as (
    select * from {{ ref('stg_sq_gnp2_lib_ods_dir_orx_trans') }}
)

select
    amt_desc as ntwk_desc,
    sysdate() as crt_tmsp,
    1 as dummyjoin
from stg_sq_gnp2_lib_ods_dir_orx_trans