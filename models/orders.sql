with payments as (
    select * from {{ ref('stg_payments') }}
    where status = 'success'
),

orders as (
    select * from {{ ref('stg_orders') }}
),

final as (
    select 
        orders.order_id, 
        orders.customer_id, 
        sum(payments.amount) as amount
    from payments 
    join orders on orders.order_id=payments.order_id
    group by orders.order_id, orders.customer_id
)

select * from final