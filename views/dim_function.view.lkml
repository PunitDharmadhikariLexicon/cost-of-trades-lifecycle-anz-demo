view: dim_function {
  sql_table_name: public.DIM_Function ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: functionname {
    type: string
    sql: ${TABLE}."functionname" ;;
  }
  dimension: functiontype {
    type: string
    sql: ${TABLE}."functiontype" ;;
  }
  dimension: subfunctionname {
    type: string
    sql: ${TABLE}."subfunctionname" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, subfunctionname, functionname]
  }
}
