view: dim_cost {
  sql_table_name: public.DIM_Cost ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: costtype {
    type: string
    sql: ${TABLE}."costtype" ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: value {
    type: number
    sql: ${TABLE}."value" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
