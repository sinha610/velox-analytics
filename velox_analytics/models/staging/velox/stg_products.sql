WITH source AS(
      SELECT * FROM {{source ('velox','products') }}
),

renamed AS(
      SELECT
            --primary key
            product_id,

            --product attributes
            sku,
            product_name,
            category AS product_category,

            --pricing
            unit_price,
            cost_price,
            round(unit_price - cost_price,2) AS gross_margin,
            round(safe_divide(unit_price - cost_price, unit_price)*100,2) AS gross_margin_pct,

            --status
            is_active AS is_product_active,

            --metadata
            created_at AS product_created_at,
            DATE(created_at) AS product_created_date

      FROM source
)

SELECT * FROM renamed