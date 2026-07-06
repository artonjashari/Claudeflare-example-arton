/** @type {import('next').NextConfig} */
const nextConfig = {
  // Static export - deploys as plain HTML/CSS/JS, works on Cloudflare Pages free plan
  // with zero extra adapters. Remove this if you need SSR/API routes (see README).
  output: 'export',
  images: {
    unoptimized: true, // Cloudflare Pages doesn't support next/image optimization on static export
  },
};

module.exports = nextConfig;
