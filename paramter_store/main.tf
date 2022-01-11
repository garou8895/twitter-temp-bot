resource "aws_ssm_parameter" "consumer_key" {
  name        = "/production/lambda/twiiterapi/consumer_key"
  type        = "SecureString"
  value       = var.consumer_key

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "client_secret" {
  name        = "/production/lambda/twiiterapi/client_secret"
  type        = "SecureString"
  value       = var.client_secret

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "access_token" {
  name        = "/production/lambda/twiiterapi/access_token"
  type        = "SecureString"
  value       = var.access_token

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "access_token_secret" {
  name        = "/production/lambda/twiiterapi/access_token_secret"
  type        = "SecureString"
  value       = var.access_token_secret

  tags = {
    System = "twb"
  }
}


resource "aws_ssm_parameter" "switchbot_token" {
  name        = "/production/lambda/twiiterapi/switchbot_token"
  type        = "SecureString"
  value       = var.switchbot_token

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "openweather_token" {
  name        = "/production/lambda/twiiterapi/openweather_token"
  type        = "SecureString"
  value       = var.openweather_token

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "lat_pl" {
  name        = "/production/lambda/twiiterapi/lat_pl"
  type        = "SecureString"
  value       = var.lat_pl

  tags = {
    System = "twb"
  }
}

resource "aws_ssm_parameter" "lon_pl" {
  name        = "/production/lambda/twiiterapi/lon_pl"
  type        = "SecureString"
  value       = var.lon_pl

  tags = {
    System = "twb"
  }
}