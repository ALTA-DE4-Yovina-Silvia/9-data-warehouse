WITH product_placements AS (
    SELECT
        shardid as shard_id,
        nodename as node_name
    FROM pg_dist_shard_placement
),
product_shards AS (
    SELECT 
        product_id,
        get_shard_id_for_distribution_column('products', product_id) as shard_id,
        'products_' || get_shard_id_for_distribution_column('products', product_id) as real_table_name
    FROM products
    WHERE name = 'Headphones'
)
SELECT
    product_shards.product_id,
    product_shards.shard_id,
    product_placements.node_name
FROM product_shards
INNER JOIN product_placements
    ON product_placements.shard_id = product_shards.shard_id;
   

