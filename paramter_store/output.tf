output "consumer_key" {
    value = aws_ssm_parameter.consumer_key.value
    sensitive = true
}

output "client_secret" {
    value = aws_ssm_parameter.client_secret.value
    sensitive = true
}

output "access_token" {
    value = aws_ssm_parameter.access_token.value
    sensitive = true
}

output "access_token_secret" {
    value = aws_ssm_parameter.access_token_secret.value
    sensitive = true
}

output "switchbot_token" {
    value = aws_ssm_parameter.switchbot_token.value
    sensitive = true
}

output "openweather_token" {
    value = aws_ssm_parameter.openweather_token.value
    sensitive = true
}

output "lat_pl" {
    value = aws_ssm_parameter.lat_pl.value
    sensitive = true
}

output "lon_pl" {
    value = aws_ssm_parameter.lon_pl.value
    sensitive = true
}