-- preciso criar um arquivo stg_blablabla pra cada tabela source
{{ config(materialized='ephemeral') }} 
-- macro para nao mostrar as tabelas stg no dw (para organizacao)
-- existe as seguintes formas: tabela vista e efemera 
-- efemero significa que ele vai usas como uma subquery, ou seja, como base para outras consultas.

with source_data as (

    select 
        customer_id,
        country,	
        city,	
        fax,
        postal_code,
        address,
        region,
        contact_name,
        phone,
        company_name,
        contact_title
    
     -- COLUNAS METADADOS
     -- _sdc_batched_at
     -- _sdc_extracted_at
     -- _sdc_sequence
     -- _sdc_received_at
     -- _sdc_table_version

    from {{ source ('academy','customers') }}

)

select *
from source_data