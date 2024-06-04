view: fact_trade {
  sql_table_name: public.FACT_Trade ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: code {
    type: string
    sql: ${TABLE}."code" ;;
  }
  dimension: costid {
    type: number
    value_format_name: id
    sql: ${TABLE}."costid" ;;
  }
  dimension: dateid {
    type: number
    value_format_name: id
    sql: ${TABLE}."dateid" ;;
  }
  dimension: metricid {
    type: number
    value_format_name: id
    sql: ${TABLE}."metricid" ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: ownerid {
    type: number
    value_format_name: id
    sql: ${TABLE}."ownerid" ;;
  }
  dimension: functionid {
    type: number
    value_format_name: id
    sql: ${TABLE}."functionid" ;;
  }
  dimension: tradestrategyid {
    type: number
    value_format_name: id
    sql: ${TABLE}."tradestrategyid" ;;
  }
  dimension: tradetype {
    type: string
    sql: ${TABLE}."tradetype" ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}."cost" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
  measure: sum {
    type: sum
    drill_fields: [cost]
  }
}
