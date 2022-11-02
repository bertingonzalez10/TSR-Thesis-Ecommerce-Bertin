view: derived_table_products {
  derived_table: {
    sql: SELECT
          products.id  AS `products.id`,
          products.retail_price  AS `products.retail_price`,
          products.item_name  AS `products.item_name`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      GROUP BY
          1,
          2,
          3
      ORDER BY
          products.id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_id {
    type: number
    sql: ${TABLE}.`products.id` ;;
  }

  dimension: products_retail_price {
    type: number
    sql: ${TABLE}.`products.retail_price` ;;
  }

  dimension: products_item_name {
    type: string
    sql: ${TABLE}.`products.item_name` ;;
  }

  set: detail {
    fields: [products_id, products_retail_price, products_item_name]
  }
}
