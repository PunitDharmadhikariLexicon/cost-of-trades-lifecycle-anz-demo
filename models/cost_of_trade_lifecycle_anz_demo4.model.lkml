connection: "cost_of_trade_anz_demo_database"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: cost_of_trade_lifecycle_anz_demo4_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cost_of_trade_lifecycle_anz_demo4_default_datagroup

explore: dim_cost {}

explore: dim_date {}

explore: dim_function {}

explore: dim_metric {}

explore: dim_owner {}

explore: dim_strategy {}

explore: fact_trade {}

