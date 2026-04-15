resource "github_repository" "repositories" {
  for_each = var.repository_map

  name       = each.key
  visibility = "public"
  fork       = true

  template {
    owner                = var.repo_owner
    repository           = each.value
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

resource "github_repository_collaborator" "collaborators" {
  # for_each = var.repository_map
  for_each = {
    for repo_key, repo_data in var.repository_map :
    repo_key => repo_data
    if var.repo_collaborator != var.repo_owner
  }

  repository = github_repository.repositories[each.key].name
  username   = var.repo_collaborator
  permission = "push"
}

resource "github_repository_webhook" "commit_webhook" {
  for_each = var.repository_map

  repository = github_repository.repositories[each.key].name

  configuration {
    url          = "${var.host}${var.github_commit_commit_webhook_path}"
    content_type = "json"
    insecure_ssl = false
    # secret       = var.webhook_secret         # HMAC secret
  }

  # Fire on every push (i.e., commits pushed to any branch/tag)
  events = ["push"]
}
