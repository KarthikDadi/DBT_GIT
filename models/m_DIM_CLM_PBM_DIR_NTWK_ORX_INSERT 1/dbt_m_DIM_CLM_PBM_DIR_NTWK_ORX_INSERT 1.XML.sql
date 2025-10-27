-- stg_ods_dir_orx_trans.sql
{{
  config(
    materialized='view',
    tags=['m_dim_clm_pbm_dir_ntwk_orx_insert']
  )
}}

with source as (
  select
    batch_id,
    batch_row_id,
    crt_tmsp,
    upd_tmsp,
    upd_user,
    row_stat_cd,
    clm_pbm_hk,
    ncpdp_hk,
    rx_hk,
    dspn_dt_hk,
    prov_nm,
    clm_sbmtd_dt,
    rx_fill_dt,
    crr_id,
    phrmcy_affl_cd,
    ncpdp_nbr,
    auth_nbr,
    clm_sts,
    rx_nbr,
    prc_pd_ingrd_cst_amt,
    amt_desc,
    dir_fee_amt,
    feed_srce_cd
  from {{ source('gnp2ods', 'ods_dir_orx_trans') }}
),
sq_gnp2_lib_ods_dir_orx_trans as (
  select distinct
    batch_id,
    batch_row_id,
    crt_tmsp,
    upd_tmsp,
    upd_user,
    row_stat_cd,
    clm_pbm_hk,
    ncpdp_hk,
    rx_hk,
    dspn_dt_hk,
    prov_nm,
    clm_sbmtd_dt,
    rx_fill_dt,
    crr_id,
    phrmcy_affl_cd,
    ncpdp_nbr,
    auth_nbr,
    clm_sts,
    rx_nbr,
    prc_pd_ingrd_cst_amt,
    amt_desc,
    dir_fee_amt,
    feed_srce_cd
  from source
  where batch_id between {{ var('min_batch_id') }} and {{ var('max_batch_id') }} 
  and row_stat_cd = 'PASS' 
  and amt_desc is not null
)
select
  batch_id,
  batch_row_id,
  crt_tmsp,
  upd_tmsp,
  upd_user,
  row_stat_cd,
  clm_pbm_hk,
  ncpdp_hk,
  rx_hk,
  dspn_dt_hk,
  prov_nm,
  clm_sbmtd_dt,
  rx_fill_dt,
  crr_id,
  phrmcy_affl_cd,
  ncpdp_nbr,
  auth_nbr,
  clm_sts,
  rx_nbr,
  prc_pd_ingrd_cst_amt,
  amt_desc,
  dir_fee_amt,
  feed_srce_cd
from sq_gnp2_lib_ods_dir_orx_trans