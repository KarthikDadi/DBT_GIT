-- stg_dim_clm_pbm_ntwk.sql
{{
  config(
    materialized='view',
    tags=['m_dim_clm_pbm_dir_ntwk_orx_insert']
  )
}}

with source_dim_clm_pbm_ntwk as (
    select
        ntwk_id
    from {{ source('gnp2data', 'dim_clm_pbm_ntwk') }}
),

sq_gnp2_lib_dim_clm_pbm_ntwk as (
    select
        max(ntwk_id) as ntwk_id
    from source_dim_clm_pbm_ntwk
)

select
    ntwk_id
from sq_gnp2_lib_dim_clm_pbm_ntwk