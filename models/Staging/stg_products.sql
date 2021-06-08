-- preciso criar um arquivo stg_blablabla pra cada tabela source
{{ config(materialized='ephemeral') }} 
-- macro para nao mostrar as tabelas stg no dw (para organizacao)
-- existe as seguintes formas: tabela vista e efemera 
-- efemero significa que ele vai usas como uma subquery, ou seja, como base para outras consultas.

with source_data as (

    select 
        product_id,
        units_in_stock,
        category_id,
        unit_price,
        product_name,
        quantity_per_unit,
        supplier_id,	
        units_on_order,
        reorder_level,
        case 
            when discontinued = 0 then 'Nao'
            else 'Sim'
        end as is_discontinued
        

    from {{ source ('academy','products') }}

)

select *
from source_data