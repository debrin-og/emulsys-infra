# HCP Terraform


# GitHub
variable "pat_token" {
  type        = string
  description = "Personal Access Token of the Github Account Owner"
  sensitive   = true
}

variable "repo_name" {
  type        = string
  description = "Name of the sandbox GitHub repository to create"
}

variable "template_repo" {
  type        = string
  description = "Template repository (short name, under repo_owner) to generate the sandbox repo from"
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

variable "webhook_secret" {
  type        = string
  description = "Shared secret GitHub uses to sign webhook deliveries (X-Hub-Signature-256, HMAC-SHA256). Must match the backend's emulsys.webhook.github-secret. Supplied via the HCPT org variable set."
  sensitive   = true
}
