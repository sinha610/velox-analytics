WITH source AS(
      SELECT * FROM {{source ('velox', 'orders') }}
),

renamed AS(
      SELECT

      --primary key
      order_id,

      --foreign key
      customer_id,

      --order attributes
      order_status,

      --date- cast timestamp to dates for easier filtering
      DATE(order_date) AS order_date,
      DATE(shipped_date) AS shipped_date,
      DATE(delivered_date) AS delivered_date,

      --financial
      discount_amount,
      shipping_amount,

      --derived flags
      CASE
            WHEN order_status = 'delivered' then true
            else false
      end AS is_delivered,

      CASE
            WHEN order_status = 'cancelled' then true
            ELSE false
      END AS is_cancelled

FROM source 
)

SELECT * FROM renamed
