WITH source AS(
      SELECT * FROM {{ source('velox', 'customers') }}
),

renamed AS (
      SELECT
            --primary key
            customer_id,

            --customer attribute
            email,
            first_name,
            last_name,
            lower(first_name || ' ' || last_name) AS full_name,
            lower(email) AS email_normalized,

            --location
            city,
            upper(country) AS country_code,

            --metadata
            created_at AS customer_created_at,
            updated_at AS customer_updated_at,
            CAST(created_at AS DATE) AS customer_created_date

      FROM source
      
)

SELECT *
FROM renamed