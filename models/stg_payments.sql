select 
    orderid as order_id,
    status as status,
    amount/100 as amount
from raw.stripe.payment