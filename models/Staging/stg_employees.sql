-- preciso criar um arquivo stg_blablabla pra cada tabela source
{{ config(materialized='ephemeral') }} 
-- macro para nao mostrar as tabelas stg no dw (para organizacao)
-- existe as seguintes formas: tabela vista e efemera 
-- efemero significa que ele vai usas como uma subquery, ou seja, como base para outras consultas.

with source_data as (

    select 
        country,	
        city,
        postal_code,
        hire_date,
        extension,
        address,
        birth_date,
        region,
        photo_path,	
        last_name,
        employee_id,	 
        first_name,
        title,
        title_of_courtesy,	
        notes,
        home_phone,
        reports_to
    
     -- COLUNAS METADADOS
     -- _sdc_table_version
     -- _sdc_received_at	
     -- _sdc_sequence
     -- _sdc_batched_at	
     -- _sdc_extracted_at

    from {{ source ('academy','employees') }}

)

select *
from source_data