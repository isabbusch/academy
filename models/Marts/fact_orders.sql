--usar preferencialmente CTEs
{{ config(materialized='table') }} 
-- macro para materializar como tabela; ao inves de view ou vista.

with orders as( 
    select *
    from {{ ref('stg_orders') }}
),

order_details as( 
    select *
    from {{ ref('stg_order_details') }}
),

customers as( 
    select *
    from {{ ref('dim_customers') }}
),

employees as( 
    select *
    from {{ ref('dim_employees') }}
),

products as( 
    select *
    from {{ ref('dim_products') }}
),

suppliers as( 
    select *
    from {{ ref('dim_suppliers') }}
),

shippers as( 
    select *
    from {{ ref('dim_shippers') }}
),

orders_with_sk as (
    select 
    orders.order_id,
    employees.employee_sk,
    -- na tabela de fatos so uso sk!
    customers.customer_sk,
    shippers.shipper_sk,
    orders.order_date,
    orders.required_date,
    orders.freight
    from orders
    left join employees on orders.employee_id = employees.employee_id
    left join shippers on orders.shipper_id = shippers.shipper_id
    left join customers on orders.customer_id = customers.customer_id
),

order_details_with_sk as (
    select 
    order_details.order_id,
    products.product_sk,
    order_details.discount,
    order_details.unit_price,
    order_details.quantity
    from order_details
    left join products on order_details.product_id = products.product_id
),

    final as (
        select
        -- na tabela de fatos so uso sk!
        order_details_with_sk.order_id,
        order_details_with_sk.product_sk,
        orders_with_sk.customer_sk,
        orders_with_sk.employee_sk,
        orders_with_sk.shipper_sk,
        orders_with_sk.order_date,
        orders_with_sk.required_date,
        orders_with_sk.freight,
        order_details_with_sk.discount,
        order_details_with_sk.unit_price,
        order_details_with_sk.quantity,
        order_details_with_sk.unit_price * order_details_with_sk.quantity as subtotal
        from order_details_with_sk
        left join orders_with_sk on order_details_with_sk.order_id = orders_with_sk.order_id  
)

select * from final