-- 1. Creates a new catalog named "demo_catalog"
CREATE CATALOG IF NOT EXISTS demo_catalog
COMMENT 'This catalog is created for Unity Catalog demo';

-- 2. Grants USAGE to a specific group on the newly created catalog
GRANT USAGE ON CATALOG demo_catalog TO `data_engineers_group`;

-- 3. Creates a schema database named "analytics" in "demo_catalog"
CREATE SCHEMA IF NOT EXISTS demo_catalog.analytics
COMMENT 'Schema for analytics data';

-- 4. Creates a managed table within the "analytics" schema
USE CATALOG demo_catalog;
USE SCHEMA analytics;

CREATE TABLE IF NOT EXISTS sales_data (
  transaction_id STRING,
  product_id STRING,
  quantity INT,
  price DECIMAL(10,2),
  transaction_date DATE
)
COMMENT 'Managed table for sales data';

-- 5. Grants SELECT privilege on "sales_data" to the data_scientists group
GRANT SELECT ON TABLE demo_catalog.analytics.sales_data TO `data_scientists_group`;

-- 6. Creates an external location named "demo_external_location"
CREATE EXTERNAL LOCATION demo_external_location
URL 's3://my-demo-bucket/my-path/'
WITH CREDENTIAL my_storage_credential
COMMENT 'External location for demo data';

-- 7. Grants read and write privileges to a group
GRANT READ, WRITE ON EXTERNAL LOCATION demo_external_location
TO `data_engineers_group`;
