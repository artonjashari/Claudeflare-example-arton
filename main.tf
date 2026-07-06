terraform {
  required_version = ">= 1.5.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Cloudflare Pages project wired to your GitHub repo.
# NOTE: Before this will work, you must connect Cloudflare to GitHub once,
# manually, in the dashboard (Workers & Pages -> Create -> Pages -> Connect to Git).
# That one-time OAuth handshake authorizes the Cloudflare GitHub App on your
# account/repo. Terraform cannot do that OAuth step for you, but once it's
# authorized, Terraform can fully manage the project config below.
resource "cloudflare_pages_project" "this" {
  account_id        = var.cloudflare_account_id
  name              = var.project_name
  production_branch = var.production_branch

  source {
    type = "github"
    config {
      owner                         = var.github_owner
      repo_name                     = var.github_repo
      production_branch             = var.production_branch
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
    }
  }

  build_config {
    build_command   = "npm run build"
    destination_dir = "out"   # matches `output: 'export'` in next.config.js
    root_dir        = ""
  }
}

resource "cloudflare_pages_domain" "custom" {
  count        = var.custom_domain == "" ? 0 : 1
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.this.name
  domain       = var.custom_domain
}
