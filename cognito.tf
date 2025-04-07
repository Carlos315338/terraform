# aws_cognito_user_pool.user_pool:
resource "aws_cognito_user_pool" "user_pool" {
  name                      = "User pool - u5spfn"
  mfa_configuration         = "OFF"
  deletion_protection       = "ACTIVE"
  user_pool_tier            = "ESSENTIALS"
  auto_verified_attributes  = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
        max_length = "2048"
        min_length = "0"
    }
  }

}

# aws_cognito_user_pool_client.user_pool_client:
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "react-nextjs-users"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  access_token_validity         = 60
  id_token_validity             = 60
  refresh_token_validity        = 5
  auth_session_validity         = 3

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = [
    "code",
  ]

  allowed_oauth_scopes = [
    "email",
    "openid",
    "phone",
  ]

  callback_urls = [
    "https://d84l1y8p4kdic.cloudfront.net",
  ]

  supported_identity_providers = [
    "COGNITO",
  ]

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

  enable_token_revocation                       = true
  enable_propagate_additional_user_context_data = false
  prevent_user_existence_errors                 = "ENABLED"

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}