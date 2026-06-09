WITH source AS(
      SELECT * FROM {{ source ('velox', 'order_items')}}
),

renamed AS(
      SELECT
            --primary key
            order_item_id,

            --foreign key
            order_id,
            product_id,

            --item attributes
            quantity,
            unit_price AS item_unit_price,
            round(quantity * unit_price,2) AS item_total_amount
      FROM source
)

SELECT * FROM renamed