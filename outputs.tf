output "id" {
  description = "The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project."
  value       = aws_codebuild_project.main.id
}

output "arn" {
  description = "The ARN of the CodeBuild project."
  value       = aws_codebuild_project.main.arn
}

output "badge_url" {
  description = "The URL of the build badge."
  value       = aws_codebuild_project.main.badge_url
}
