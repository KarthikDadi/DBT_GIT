-- transformation_name: fil_new_records
{{ config(
    materialized='table',
    tags=["m_dim_clm_pbm_dir_ntwk_orx_insert"]
) }}

with int_lkp_dim_pln_ntwk as (
    select * from {{ ref('int_lkp_dim_pln_ntwk') }}
),

int_fil_new_records as (
    select
        lkp_ntwk_desc,
        ntwk_desc1,
        crt_tmsp1,
        dummyjoin
    from
        int_lkp_dim_pln_ntwk
    where
        lkp_ntwk_desc is null
)

select
    lkp_ntwk_desc,
    ntwk_desc1,
    crt_tmsp1,
    dummyjoin
from
    int_fil_new_records