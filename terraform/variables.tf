variable "region" {
  description = "The AWS region to deploy resources"
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for the front-end app"
  default     = "example-frontend-bucket"
}
