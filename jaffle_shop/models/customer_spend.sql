{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

customer_spend as (
    select
        customer_id,
        sum(amount) as total_amount_spent
    from orders
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        coalesce(cs.total_amount_spent, 0) as total_amount_spent
    from {{ ref('stg_customers') }} c
    left join customer_spend cs using (customer_id)
)

select * from final