output "pages_url" {
  description = "Default *.pages.dev URL"
  value       = "https://${cloudflare_pages_project.this.name}.pages.dev"
}

output "project_subdomain" {
  value = cloudflare_pages_project.this.subdomain
}
