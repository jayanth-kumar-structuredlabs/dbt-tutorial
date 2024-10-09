{{ config(materialized='table') }}

with customer_orders as (
    select
        customer_id,
        sum(order_amount) as total_amount_spent
    from {{ ref('stg_orders') }}
    group by customer_id
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(co.total_amount_spent, 0) as total_amount_spent
from {{ ref('stg_customers') }} c
left join customer_orders co using (customer_id)
order by total_amount_spent desc