resource "aws_acm_certificate" "cloudfront" {
  provider          = aws.us_east_1
  domain_name       = "videos.teched-platform.xyz"
  validation_method = "DNS"
  region            = "us-east-1"               # x cloudfront obbligatorio

  lifecycle {
    create_before_destroy = true
  }

}
