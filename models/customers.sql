with stg_customers as (
    select * from {{ ref('stg_customers') }}
),

stg_orders as (
    select * from {{ ref('stg_orders') }}
),

orders as (
    select * from {{ ref('orders') }}
),

customer_orders as (

    select
        stg_orders.customer_id,
        min(stg_orders.order_date) as first_order_date,
        max(stg_orders.order_date) as most_recent_order_date,
        count(stg_orders.order_id) as number_of_orders,
        sum(orders.amount) as lifetime_value

    from stg_orders 
    join orders on orders.order_id=stg_orders.order_id

    group by 1

),


final as (

    select
        stg_customers.customer_id,
        stg_customers.first_name,
        stg_customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value

    from stg_customers

    left join customer_orders using (customer_id)

)

select * from final