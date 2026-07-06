# Next.js → GitHub → Terraform → Cloudflare Pages (Free Plan)

Minimal static-export Next.js app, deployed to Cloudflare Pages, with the
Pages project itself provisioned via Terraform and wired to a GitHub repo.

## 1. Push this directory to GitHub

```bash
cd nextjs-cloudflare-example
git init
git add .
git commit -m "Initial commit: Next.js example"
gh repo create nextjs-cloudflare-example --public --source=. --remote=origin --push
```

(No `gh` CLI? Create an empty repo on github.com, then:)

```bash
git remote add origin https://github.com/<your-username>/nextjs-cloudflare-example.git
git branch -M main
git push -u origin main
```

## 2. One-time: authorize Cloudflare's GitHub App

Terraform can create/configure the Pages project, but the GitHub↔Cloudflare
OAuth connection has to be authorized once by a human in the dashboard —
there's no API for it:

1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com) (free plan is fine).
2. Go to **Workers & Pages → Create → Pages → Connect to Git**.
3. Authorize the **Cloudflare Pages** GitHub App and grant it access to this repo.
4. You can stop right there in the wizard (don't finish creating the project) —
   Terraform will manage the actual project config from here.

## 3. Get your Cloudflare credentials

- **API Token**: Dashboard → My Profile → API Tokens → Create Token → use the
  "Edit Cloudflare Workers" template or a custom token with `Account.Cloudflare Pages: Edit`.
- **Account ID**: Dashboard → any domain/Workers & Pages overview page → right sidebar.

## 4. Configure Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your real token, account id, github owner/repo
```

## 5. Apply

```bash
terraform init
terraform plan
terraform apply
```

This creates a `cloudflare_pages_project` pointed at your GitHub repo/branch.
Every push to `main` now auto-builds and deploys — Cloudflare pulls the repo,
runs `npm run build`, and serves the `out/` directory (static export).

Terraform will print your `https://<project>.pages.dev` URL when done.

## Notes / options

- **This app uses `output: 'export'`** in `next.config.js` — a fully static
  build. It's the simplest path and fits the Cloudflare Pages free plan with
  zero extra tooling.
- **Need SSR / API routes / middleware instead?** Use the
  [`@cloudflare/next-on-pages`](https://github.com/cloudflare/next-on-pages)
  adapter, remove `output: 'export'`, and change the Terraform
  `build_command` to `npx @cloudflare/next-on-pages@1` with
  `destination_dir = ".vercel/output/static"`.
- **Free plan limits**: 500 builds/month, unlimited requests/bandwidth,
  unlimited sites — plenty for this example.
- **Custom domain**: set `custom_domain` in `terraform.tfvars` and re-apply;
  the domain must already exist as a zone in your Cloudflare account.
