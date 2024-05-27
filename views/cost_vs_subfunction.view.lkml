
view: cost_vs_subfunction {
  derived_table: {
    sql: WITH fact_trade_vs_subfunction_name AS (WITH fact_trade_vs_subfunction AS (SELECT
                    dim_function."id" AS "dim_function.id",
                    dim_function."subfunctionname" AS "dim_function.subfunctionname",
                    COALESCE(SUM(CAST((fact_trade."value") AS DOUBLE PRECISION)), 0) AS "sum_of_value"
                  FROM public."FACT_Trade" AS fact_trade
                  LEFT JOIN public."DIM_Function" AS dim_function ON fact_trade."segmentid" = dim_function."id"
                  GROUP BY dim_function."id", dim_function."subfunctionname"
                  ORDER BY dim_function."id" ASC
                  LIMIT 500
                  )
            SELECT
                fact_trade_vs_subfunction."dim_function.subfunctionname"  AS "Sub-Function",
                fact_trade_vs_subfunction."dim_function.functionname"  AS "Function-Name",
                CAST(fact_trade_vs_subfunction."dim_function.id" AS INTEGER) AS "SortKey",
                fact_trade_vs_subfunction."sum_of_value"  AS "Sum of Cost"
            FROM fact_trade_vs_subfunction
            GROUP BY
                1,
                2,
                3
            ORDER BY
                2
            FETCH NEXT 500 ROWS ONLY )
      SELECT
          fact_trade_vs_subfunction_name."SortKey"  AS "SortKey",
          fact_trade_vs_subfunction_name."Function-Name"  AS "Function",
          fact_trade_vs_subfunction_name."Sub-Function"  AS "Sub-Function",
          fact_trade_vs_subfunction_name."Sum of Cost"  AS "Cost"
      FROM fact_trade_vs_subfunction_name
      GROUP BY
          3,
          2,
          4,
          1,
      ORDER BY
          1
      FETCH NEXT 500 ROWS ONLY ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sort_key {
    type: number
    sql: ${TABLE}."SortKey" ;;
  }

  dimension: ftvsn_fact_trade_vs_subfunction_subfunctionname {
    type: string
    sql: ${TABLE}."ftvsn.fact_trade_vs_subfunction_subfunctionname" ;;
  }

  dimension: ftvsn_fact_trade_vs_subfunction_sum_of_value {
    type: number
    sql: ${TABLE}."ftvsn.fact_trade_vs_subfunction_sum_of_value" ;;
  }

  set: detail {
    fields: [
        sort_key,
  ftvsn_fact_trade_vs_subfunction_subfunctionname,
  ftvsn_fact_trade_vs_subfunction_sum_of_value
    ]
  }
}
