--usar preferencialmente CTEs
--{{ config(materialized='table') }} 
-- macro para materializar como tabela; ao inves de view ou vista.

with staging as( 
    select *
    from {{ ref('stg_customers') }}
),
final as (
    select 
    row_number() over (order by customer_id) as customer_sk, --chave surrogate auto incremental
    *
    from staging
)

select * from final