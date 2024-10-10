{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customer_orders as (
    select
        orders.customer_id,
        sum(payments.amount) as total_amount_spent
    from orders
    left join payments on orders.order_id = payments.order_id
    group by 1
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        coalesce(customer_orders.total_amount_spent, 0) as total_amount_spent
    from {{ ref('stg_customers') }} as customers
    left join customer_orders using (customer_id)
)

select * from final