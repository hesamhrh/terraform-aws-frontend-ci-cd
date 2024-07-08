provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "frontend_app_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "frontend_app_bucket_ownership" {
  bucket = aws_s3_bucket.frontend_app_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "frontend_app_bucket_policy" {
  bucket = aws_s3_bucket.frontend_app_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "${aws_cloudfront_origin_access_identity.frontend_app_identity.iam_arn}"
        },
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.frontend_app_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_cloudfront_distribution" "frontend_app_cdn" {
  origin {
    domain_name = aws_s3_bucket.frontend_app_bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.frontend_app_bucket.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.frontend_app_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.frontend_app_bucket.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 403
    response_code      = 403
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
  }

  tags = {
    Name = "FrontendAppCDN"
  }
}

resource "aws_cloudfront_origin_access_identity" "frontend_app_identity" {
  comment = "Origin Access Identity for Frontend App S3 bucket"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.frontend_app_bucket.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.frontend_app_cdn.id
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.frontend_app_cdn.domain_name
}
