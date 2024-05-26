view: fact_trade_vs_subfunction {
  derived_table: {
    sql:
      SELECT
        dim_function."id" AS "dim_function.id",
        dim_function."subfunctionname" AS "dim_function.subfunctionname",
        COALESCE(SUM(CAST((fact_trade."value") AS DOUBLE PRECISION)), 0) AS "sum_of_value"
      FROM public."FACT_Trade" AS fact_trade
      LEFT JOIN public."DIM_Function" AS dim_function ON fact_trade."segmentid" = dim_function."id"
      GROUP BY dim_function."id", dim_function."subfunctionname"
      ORDER BY dim_function."id" ASC
      LIMIT 500
      ;;
  }
  dimension: dim_function_id {
    type: number
    sql: ${TABLE}."dim_function.id" ;;
  }
  dimension: subfunctionname {
    type: string
    sql: ${TABLE}."dim_function.subfunctionname" ;;
  }
  measure: sum_of_value {
    type: number
    sql: ${TABLE}."sum_of_value" ;;
  }
}

# view: fact_trade_vs_subfunction {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
