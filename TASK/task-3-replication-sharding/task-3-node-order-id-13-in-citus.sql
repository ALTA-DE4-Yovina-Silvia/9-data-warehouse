WITH order_placements AS (
    SELECT
        shardid as shard_id,
        nodename as node_name
    FROM pg_dist_shard_placement
),
order_shards AS (
    SELECT 
        order_id,
        get_shard_id_for_distribution_column('orders', order_id) as shard_id,
        'orders_' || get_shard_id_for_distribution_column('orders', order_id) as real_table_name
    FROM orders
    WHERE order_id = 13
)
SELECT
    order_shards.order_id,
    order_shards.shard_id,
    order_placements.node_name
FROM order_shards
INNER JOIN order_placements
    ON order_placements.shard_id = order_shards.shard_id;
