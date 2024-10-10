{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

customer_spend as (
    select
        customer_id,
        sum(order_amount) as total_spend
    from orders
    group by customer_id
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    coalesce(customer_spend.total_spend, 0) as total_spend
from customers
left join customer_spend using (customer_id)
order by total_spend desc