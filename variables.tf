# HCP Terraform


# GitHub
variable "pat_token" {
  type        = string
  description = "Personal Access Token of the Github Account Owner"
  sensitive   = true
}

variable "repository_map" {
  type        = map(string)
  description = "Map of GitHub repository name to it's template repository"
}

variable "repo_owner" {
  type        = string
  description = "GitHub org that owns the created sandbox repos and their templates (set by the backend run variable; this default is a CLI fallback)"
  default     = "emulsys-sandbox-org"
}

variable "repo_collaborator" {
  type = string
  description = "GitHub username of the user"
}

variable "host" {
  type        = string
  description = "Hostname which receives the commit webhook"
  default     = "https://lasting-muskrat-sharply.ngrok-free.app"
}

variable "github_commit_commit_webhook_path" {
  type        = string
  description = "URL path where the commit webhook should be sent"
  default     = "/api/v1/hooks/github/commits"
}
