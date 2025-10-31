-- trans_exp_define_ntwk_id.sql
{{ config(materialized='table', tags=["m_DIM_CLM_PBM_DIR_NTWK_ORX_INSERT"]) }}

with int_srt_ntwk_desc as (
    select
        ntwk_desc1,
        max_ntwk_id,
        crt_tmsp1
    from {{ ref('int_srt_ntwk_desc') }}
),

trans_exp_define_ntwk_id as (
    -- transformation logic for exp_define_ntwk_id
    -- calculating ports in the order of their definition in the xml to handle dependencies.
    select
        -- port 1: ntwk_desc (input/output)
        ntwk_desc1 as ntwk_desc,

        -- port 5: crt_tmsp (input/output)
        crt_tmsp1 as crt_tmsp,

        -- port 7: ntwk_id (output)
        -- expression: v_ntwk_id + max_ntwk_id
        -- the variable v_ntwk_id logic is: iif(isnull(prev_ntwk_desc),1, iif(prev_ntwk_desc <> ntwk_desc,prev_ntwk_id+1))
        -- this is equivalent to dense_rank() on a sorted input.
        (dense_rank() over (order by ntwk_desc1)) + max_ntwk_id as ntwk_id

    from int_srt_ntwk_desc
)

-- final selection of output-enabled ports in the order defined in the xml.
select
    ntwk_desc,
    crt_tmsp,
    ntwk_id
from trans_exp_define_ntwk_id