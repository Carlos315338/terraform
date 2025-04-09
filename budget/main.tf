# aws_budgets_budget.presupuesto_mensual_general:
resource "aws_budgets_budget" "presupuesto_mensual_general" {
  name              = "presupuesto_mensual_general"
  budget_type       = "COST"
  limit_amount      = "1.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2025-04-01_00:00"

  cost_types {
    include_credit             = false
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = false
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    threshold                  = 0.01
    threshold_type             = "ABSOLUTE_VALUE"
    subscriber_email_addresses = [
      "breiner2552@gmail.com",
      "wiki.vltg18@gmail.com",
    ]
  }
}