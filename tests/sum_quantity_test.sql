with 
    sum_quantity as (
        select
            sum(quantity) as qnt
        from {{ ref('fact_orders')}}
        where order_date
        between '1998-03-01' and '1998-03-31'
    )

select * from sum_quantity where qnt != 4065