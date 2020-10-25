resource "aws_codebuild_project" "main" {
  name        = local.name
  description = local.name

  build_timeout = "5"
  service_role  = aws_iam_role.main.arn


  badge_enabled = true

  artifacts {
    type = "NO_ARTIFACTS"
  }

  #cache {
  #  type     = "S3"
  #  location = aws_s3_bucket.example.bucket
  #}

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # Make use of the cloud environment
    environment_variable {
      name  = "DJANGO_SETTINGS_PROFILE"
      value = "cloud"
    }

    environment_variable {
      name  = "DJANGO_SETTINGS_PREFIX"
      value = var.config_path
    }

    # Just a sample
    environment_variable {
      name  = "DATABASE_SECRET_ARN"
      value = format("%s/%s", var.config_path, "DATABASE_SECRET_ARN")
      type  = "PARAMETER_STORE"
    }
  }

  #logs_config {
  #  cloudwatch_logs {
  #    group_name  = "log-group"
  #    stream_name = "log-stream"
  #  }

  #  s3_logs {
  #    status   = "ENABLED"
  #    location = "${aws_s3_bucket.example.id}/build-log"
  #  }
  #}

  source {
    type     = "GITHUB"
    location = var.git_repo
    # TODO: HardCode
    buildspec       = var.buildspec_path
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = var.git_ref

  vpc_config {
    vpc_id             = data.aws_vpc.main.id
    subnets            = local.subnets
    security_group_ids = local.security_groups
  }

  tags = merge(
    map(
      "Name", local.name,
    ),
    var.tags
  )
}
