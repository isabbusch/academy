-- preciso criar um arquivo stg_blablabla pra cada tabela source
{{ config(materialized='ephemeral') }} 
-- macro para nao mostrar as tabelas stg no dw (para organizacao)
-- existe as seguintes formas: tabela vista e efemera 
-- efemero significa que ele vai usas como uma subquery, ou seja, como base para outras consultas.

with source_data as (

    select 
        product_id,
        order_id,
        discount,
        unit_price,
        quantity
    
     -- COLUNAS METADADOS
     -- _sdc_batched_at
     -- _sdc_extracted_at
     -- _sdc_sequence
     -- _sdc_received_at
     -- _sdc_table_version

    from {{ source ('academy','order_details') }}

)

select *
from source_data