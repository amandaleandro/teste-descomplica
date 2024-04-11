output "bucket_id" {
  description = "O ID do bucket S3"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "O ARN do bucket S3"
  value       = aws_s3_bucket.bucket.arn
}

output "cloudfront_distribution_id" {
  description = "O ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_distribution_domain_name" {
  description = "O nome de domínio da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}output "bucket_id" {
  description = "O ID do bucket S3"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "O ARN do bucket S3"
  value       = aws_s3_bucket.bucket.arn
}

output "cloudfront_distribution_id" {
  description = "O ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_distribution_domain_name" {
  description = "O nome de domínio da distribuição CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}