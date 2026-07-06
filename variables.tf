variable "cloudflare_api_token" {
  description = "Cloudflare API token with 'Pages: Edit' permission"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Your Cloudflare account ID (Dashboard -> right sidebar)"
  type        = string
}

variable "project_name" {
  description = "Name of the Cloudflare Pages project"
  type        = string
  default     = "nextjs-cloudflare-example"
}

variable "github_owner" {
  description = "GitHub username or org that owns the repo"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name (without owner)"
  type        = string
  default     = "nextjs-cloudflare-example"
}

variable "production_branch" {
  description = "Branch that triggers production deploys"
  type        = string
  default     = "main"
}

variable "custom_domain" {
  description = "Optional custom domain to attach (leave empty to skip)"
  type        = string
  default     = ""
}
