select
    id as order_id,
    user_id as customer_id,
    order_date as order_date,
    status as status
from raw.jaffle_shop.orders
