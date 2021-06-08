-- preciso criar um arquivo stg_blablabla pra cada tabela source
{{ config(materialized='ephemeral') }} 
-- macro para nao mostrar as tabelas stg no dw (para organizacao)
-- existe as seguintes formas: tabela vista e efemera 
-- efemero significa que ele vai usas como uma subquery, ou seja, como base para outras consultas.

with source_data as (

    select 
        ship_region,
        shipped_date,
        ship_country,
        order_id,
        ship_name,
        employee_id,
        order_date,	
        customer_id,	
        ship_postal_code,	
        ship_city,
        freight,	
        ship_via as shipper_id,	
        required_date,
        ship_address	

    
     -- COLUNAS METADADOS
     -- _sdc_batched_at
     -- _sdc_extracted_at
     -- _sdc_sequence
     -- _sdc_received_at
     -- _sdc_table_version

    from {{ source ('academy','orders') }}

)

select *
from source_data