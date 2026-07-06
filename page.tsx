export default function Home() {
  return (
    <main style={{ fontFamily: 'sans-serif', padding: '3rem', maxWidth: 640, margin: '0 auto' }}>
      <h1>🚀 Next.js on Cloudflare Pages</h1>
      <p>
        This static Next.js app was pushed to GitHub and deployed to Cloudflare Pages,
        with the Pages project itself provisioned by Terraform.
      </p>
      <p>Edit <code>app/page.tsx</code> and push to redeploy.</p>
    </main>
  );
}
