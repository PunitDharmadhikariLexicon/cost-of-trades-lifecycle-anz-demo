
view: cost_vs_subfunction {
  derived_table: {
    sql: WITH fact_trade_vs_subfunction AS (
    SELECT
        dim_function."id" AS "dim_function_id",
        dim_function."subfunctionname" AS "dim_function_subfunctionname",
        dim_function."functionname" AS "dim_function_functionname",
        COALESCE(SUM(CAST(fact_trade."value" AS DOUBLE PRECISION)), 0) AS "sum_of_value"
    FROM public."FACT_Trade" AS fact_trade
    LEFT JOIN public."DIM_Function" AS dim_function ON fact_trade."segmentid" = dim_function."id"
    GROUP BY dim_function."id", dim_function."subfunctionname", dim_function."functionname"
    ORDER BY dim_function."id" ASC
    LIMIT 500
)

SELECT
    fact_trade_vs_subfunction."dim_function_id" AS "SortKey",
    fact_trade_vs_subfunction."dim_function_functionname" AS "Function",
    fact_trade_vs_subfunction."dim_function_subfunctionname" AS "Sub_Function",
    fact_trade_vs_subfunction."sum_of_value" AS "Cost"
FROM fact_trade_vs_subfunction
ORDER BY "SortKey"
FETCH NEXT 500 ROWS ONLY;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sort_key {
    type: number
    sql: ${TABLE}."SortKey" ;;
  }

  dimension: Sub_Function {
    type: string
    sql: ${TABLE}."Sub_Function" ;;
  }

  dimension: Function {
    type: string
    sql: ${TABLE}."Function" ;;
  }

  dimension: Cost {
    type: number
    sql: ${TABLE}."Cost" ;;
  }

  set: detail {
    fields: [
        sort_key,
        Sub_Function,
        Function,
        Cost
    ]
  }
  measure: DrillField {
    type: sum
    drill_fields: [
      Sub_Function,
      Function
    ]
  }

}
