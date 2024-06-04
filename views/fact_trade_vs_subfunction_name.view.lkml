
view: fact_trade_vs_subfunction_name {
  derived_table: {
    sql: WITH fact_trade_vs_subfunction AS (SELECT
              dim_function."id" AS "dim_function.id",
              dim_function."subfunctionname" AS "dim_function.subfunctionname",
              COALESCE(SUM(CAST((fact_trade."cost") AS DOUBLE PRECISION)), 0) AS "sum_of_value"
            FROM public."FACT_Trade" AS fact_trade
            LEFT JOIN public."DIM_Function" AS dim_function ON fact_trade."functionid" = dim_function."id"
            GROUP BY dim_function."id", dim_function."subfunctionname"
            ORDER BY dim_function."id" ASC
            LIMIT 500
            )
      SELECT
          fact_trade_vs_subfunction."dim_function.subfunctionname"  AS "Sub-Function",
          CAST(fact_trade_vs_subfunction."dim_function.id" AS INTEGER) AS "SortKey",
          fact_trade_vs_subfunction."sum_of_value"  AS "Sum of Cost"
      FROM fact_trade_vs_subfunction
      GROUP BY
          1,
          2,
          3
      ORDER BY
          2
      FETCH NEXT 500 ROWS ONLY ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fact_trade_vs_subfunction_subfunctionname {
    type: string
    sql: ${TABLE}."Sub-Function" ;;
  }

  dimension: fact_trade_vs_subfunction_dim_function_id {
    type: number
    sql: ${TABLE}."SortKey" ;;
  }

  dimension: fact_trade_vs_subfunction_sum_of_value {
    type: number
    sql: ${TABLE}."Sum of Cost" ;;
  }

  set: detail {
    fields: [
        fact_trade_vs_subfunction_subfunctionname,
        fact_trade_vs_subfunction_dim_function_id,
        fact_trade_vs_subfunction_sum_of_value
    ]
  }
}
