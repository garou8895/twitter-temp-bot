terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

module "parameter_store" {
  source = "./paramter_store"
  consumer_key = var.consumer_key
  client_secret = var.client_secret
  access_token = var.access_token
  access_token_secret = var.access_token_secret
  switchbot_token = var.switchbot_token
  openweather_token = var.openweather_token
  lat_pl = var.lat_pl
  lon_pl = var.lon_pl
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "twitter_bot_function" {

  filename      = "twitter-bot-hello.zip"
  function_name = "twitter_bot_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = 256
  timeout       = 10

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("twitter-bot-hello.zip")

  runtime = "python3.9"
  tags = {
    Name = "twitter_bot_function"
    System = "twb"
  }

  environment {
    variables = {
      consumer_key = module.parameter_store.consumer_key
      client_secret = module.parameter_store.client_secret
      access_token = module.parameter_store.access_token
      access_token_secret = module.parameter_store.access_token_secret
      switchbot_token = module.parameter_store.switchbot_token
      openweather_token = module.parameter_store.openweather_token
      lat_pl = module.parameter_store.lat_pl
      lon_pl = module.parameter_store.lon_pl
    }
    
  }
}