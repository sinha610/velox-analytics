WITH source AS(
      SELECT * FROM {{ source ('velox', 'payments')}}
),

renamed AS(
      SELECT
            --primary key
            payment_id,

            --foreign key
            order_id,

            --payment attributes
            payment_method,
            payment_status,
            amount,

            --dates
            paid_at,
            DATE(paid_at) AS payment_date,

            --flags
            CASE
                  WHEN payment_status = 'paid' THEN true
                  ELSE false
            END AS is_paid
      FROM source)

SELECT * FROM renamed