resource "github_repository" "repository" {
  name       = var.repo_name
  visibility = "private"
  fork       = true

  template {
    owner                = var.repo_owner
    repository           = var.template_repo
    include_all_branches = false
  }

  lifecycle {
    ignore_changes = [
      fork,
      topics,
      security_and_analysis,
      vulnerability_alerts,
    ]
  }
}

resource "github_repository_collaborator" "collaborator" {
  count = var.repo_collaborator != var.repo_owner ? 1 : 0

  repository = github_repository.repository.name
  username   = var.repo_collaborator
  permission = "push"
}

resource "github_repository_webhook" "commit_webhook" {
  repository = github_repository.repository.name

  configuration {
    url          = "${var.host}${var.github_commit_commit_webhook_path}"
    content_type = "json"
    insecure_ssl = false
    # secret       = var.webhook_secret         # HMAC secret
  }

  # Fire on every push (i.e., commits pushed to any branch/tag)
  events = ["push"]
}
