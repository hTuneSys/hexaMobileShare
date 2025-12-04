<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# Widgetbook Deployment Guide

This document explains how the hexaMobileShare Widgetbook is automatically deployed to GitHub Pages, providing a live preview of all 218+ component stories.

---

## 📌 Table of Contents

- [Overview](#overview)
- [Live Preview URL](#live-preview-url)
- [Deployment Workflow](#deployment-workflow)
- [Custom Domain Configuration](#custom-domain-configuration)
- [Manual Deployment](#manual-deployment)
- [Troubleshooting](#troubleshooting)
- [CI/CD Pipeline Details](#cicd-pipeline-details)

---

## Overview

The **Widgetbook** is our interactive component catalog built with the `widgetbook_kit` package. It contains 218+ story files showcasing all widgets, utilities, and services from the 11 modular kits in hexaMobileShare.

**Key Features:**
- 🎨 Visual component library
- 🔍 Interactive props/knobs for testing widgets
- 📱 Responsive preview modes (mobile, tablet, desktop)
- 🌙 Dark/light mode support
- ♿ Accessibility testing
- 📖 Documentation alongside components

---

## Live Preview URL

The Widgetbook is automatically deployed to:

**🔗 https://story.mobile.dev.hexatune.com**

This URL is updated automatically when PRs are merged to the `develop` branch.

---

## Deployment Workflow

### Automatic Deployment

The Widgetbook is deployed automatically using GitHub Actions. The workflow is triggered when:

1. **A Pull Request is merged to `develop`** (if it modifies Widgetbook or package files)
2. **Manual workflow dispatch** (via GitHub Actions UI)

### Deployment Trigger Conditions

The workflow runs when:
- PRs are **merged** (not just opened or closed without merging) into `develop`
- Changes are made to:
  - `widgetbook_kit/**` (Widgetbook app code)
  - `packages/**` (Any kit changes that affect stories)
  - `.github/workflows/widgetbook-deploy.yml` (Workflow configuration)

### Workflow Steps

The deployment process consists of two jobs:

#### 1. **Build Job**
```yaml
- Checkout repository
- Setup Flutter 3.x (stable channel)
- Install Melos (monorepo tool)
- Bootstrap all packages
- Build Widgetbook for web (--release mode)
- Upload build artifacts to GitHub Pages
```

#### 2. **Deploy Job**
```yaml
- Deploy artifacts to GitHub Pages
- Output deployment URL
- Generate deployment summary
```

---

## Custom Domain Configuration

### GitHub Pages Settings

To configure the custom domain `story.mobile.dev.hexatune.com`:

1. **Repository Settings:**
   - Navigate to: `Settings > Pages`
   - **Source:** Deploy from a branch
   - **Branch:** `gh-pages` (auto-created by workflow)
   - **Custom domain:** `story.mobile.dev.hexatune.com`
   - Enable **Enforce HTTPS**

2. **DNS Configuration:**
   
   Add the following DNS records at your domain provider (for `hexatune.com`):

   ```
   Type:  CNAME
   Name:  story.mobile.dev
   Value: htuneSys.github.io
   TTL:   3600 (or default)
   ```

3. **Verification:**
   
   Wait for DNS propagation (5-60 minutes), then verify:
   ```bash
   dig story.mobile.dev.hexatune.com +short
   # Should return: htuneSys.github.io
   ```

4. **HTTPS Certificate:**
   
   GitHub Pages will automatically provision an SSL certificate via Let's Encrypt once DNS is verified.

### Base HREF Configuration

The Widgetbook build uses `--base-href "/hexaMobileShare/"` to ensure assets load correctly:

```bash
flutter build web --release --base-href "/hexaMobileShare/"
```

**Note:** If using a custom domain at the root (e.g., `https://story.mobile.dev.hexatune.com`), the base-href should be `/` instead. Update the workflow if needed:

```yaml
# For root domain deployment
run: flutter build web --release --base-href "/"
```

---

## Manual Deployment

### Option 1: Via GitHub Actions UI

1. Go to: `Actions > Deploy Widgetbook to GitHub Pages`
2. Click **Run workflow**
3. Select branch: `develop`
4. Click **Run workflow**

### Option 2: Via Local Build + Manual Upload

```bash
# 1. Build Widgetbook locally
cd widgetbook_kit
flutter build web --release --base-href "/hexaMobileShare/"

# 2. The build output is in: widgetbook_kit/build/web
# Manually upload this directory to GitHub Pages or hosting provider
```

### Option 3: Via pnpm Script

```bash
# Build Widgetbook for deployment
pnpm build-storybook

# Output: widgetbook_kit/build/web
```

---

## Troubleshooting

### Issue: Deployment fails with "No such file or directory"

**Cause:** Build artifacts not found in `widgetbook_kit/build/web`

**Solution:**
1. Check Flutter build logs for errors
2. Ensure `melos bootstrap` ran successfully
3. Verify all package dependencies are installed
4. Run locally to reproduce:
   ```bash
   cd widgetbook_kit
   flutter build web --release
   ```

### Issue: Assets not loading (404 errors)

**Cause:** Incorrect `--base-href` configuration

**Solution:**
- For GitHub Pages with repository path: `--base-href "/hexaMobileShare/"`
- For custom domain at root: `--base-href "/"`

Update `.github/workflows/widgetbook-deploy.yml` accordingly.

### Issue: Custom domain shows 404

**Cause:** DNS not configured or CNAME file missing

**Solution:**
1. Verify DNS records:
   ```bash
   dig story.mobile.dev.hexatune.com +short
   ```
2. Check GitHub Pages settings for custom domain
3. Ensure `CNAME` file exists in `gh-pages` branch (auto-created by workflow)

### Issue: Deployment successful but site not updating

**Cause:** Browser cache or CDN caching old version

**Solution:**
1. Hard refresh: `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)
2. Clear browser cache
3. Wait 5-10 minutes for GitHub Pages CDN to propagate changes
4. Check deployment timestamp in GitHub Actions logs

### Issue: Workflow doesn't trigger on merged PR

**Cause:** PR didn't modify watched paths or wasn't properly merged

**Solution:**
1. Verify PR was **merged** (not just closed)
2. Check if changes affected:
   - `widgetbook_kit/**`
   - `packages/**`
   - `.github/workflows/widgetbook-deploy.yml`
3. Manually trigger workflow via Actions UI

---

## CI/CD Pipeline Details

### Workflow File

**Location:** `.github/workflows/widgetbook-deploy.yml`

### Permissions

The workflow requires:
- `contents: read` – Read repository contents
- `pages: write` – Deploy to GitHub Pages
- `id-token: write` – OIDC token for secure deployment

### Concurrency Control

```yaml
concurrency:
  group: "pages"
  cancel-in-progress: false
```

This ensures:
- Only one deployment runs at a time
- In-progress deployments complete (not cancelled)
- Queued deployments wait for current to finish

### Build Configuration

**Flutter Version:** 3.x (stable channel)
**Build Mode:** `--release` (optimized for production)
**Target Platform:** Web
**Cache:** Enabled for faster builds

### Artifact Upload

Build artifacts are uploaded using `actions/upload-pages-artifact@v3`:
- **Source:** `widgetbook_kit/build/web`
- **Retention:** 90 days (GitHub default)

### Deployment Environment

```yaml
environment:
  name: github-pages
  url: ${{ steps.deployment.outputs.page_url }}
```

This creates a deployment record visible in:
- Repository **Environments** tab
- PR **Deployments** section

---

## Monitoring Deployments

### Via GitHub Actions

1. Go to: `Actions > Deploy Widgetbook to GitHub Pages`
2. View recent workflow runs
3. Check logs for build/deploy details

### Via Deployment Summary

After successful deployment, the workflow outputs a summary:

```
🎉 Widgetbook Deployment Successful!

Live Preview: https://story.mobile.dev.hexatune.com
GitHub Pages URL: https://htuneSys.github.io/hexaMobileShare/

The Widgetbook catalog is now available with 218+ interactive component stories.
```

### Via Repository Environments

1. Go to: `Settings > Environments > github-pages`
2. View deployment history
3. Check deployment status and timestamps

---

## Best Practices

### 1. Test Before Merging

Always test Widgetbook changes locally before merging:

```bash
pnpm storybook
# Verify all stories render correctly at http://localhost:8080
```

### 2. Review Build Logs

Check GitHub Actions logs after deployment to ensure:
- No Flutter build warnings
- All assets compiled correctly
- Deployment completed successfully

### 3. Update Stories with Code Changes

When modifying packages, update corresponding Widgetbook stories:
- Add new story files for new components
- Update existing stories when widget APIs change
- Remove deprecated story files

### 4. Monitor Performance

Widgetbook builds can be large. Optimize by:
- Using `--release` mode (done automatically)
- Enabling web optimizations in `flutter build web`
- Monitoring build artifact size

### 5. Keep Dependencies Updated

Regularly update Widgetbook dependencies:

```bash
cd widgetbook_kit
flutter pub upgrade
```

Run tests after updates:

```bash
flutter test
```

---

## Related Documentation

- **[Getting Started](GETTING_STARTED.md)** – Project setup guide
- **[Development Guide](DEVELOPMENT_GUIDE.md)** – Development workflow
- **[CI Strategy](../AGENTS.md#contribution-workflow)** – CI/CD overview
- **[Project Structure](PROJECT_STRUCTURE.md)** – Repository organization

---

## Support

For deployment issues or questions:

- **GitHub Issues:** [hTuneSys/hexaMobileShare/issues](https://github.com/hTuneSys/hexaMobileShare/issues)
- **Discussions:** [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- **Email:** info@hexatune.com

---

**Last Updated:** 2025-12-05  
**Maintained by:** hexaTune LLC
