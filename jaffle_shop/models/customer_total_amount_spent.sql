{{
  config(
    materialized='table'
  )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_amounts as (
    select
        customer_id,
        order_id,
        amount
    from orders
),

customer_total_amount as (
    select
        customer_id,
        sum(amount) as total_amount_spent
    from order_amounts
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        coalesce(cta.total_amount_spent, 0) as total_amount_spent
    from {{ ref('stg_customers') }} c
    left join customer_total_amount cta using (customer_id)
)

select * from final