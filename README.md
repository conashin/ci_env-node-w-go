# Node.js + Go Custom Docker Image

This repository contains a Dockerfile and GitHub Actions workflow to build and publish a custom Docker image that combines **Node.js** and **Go (Golang)**.

This image is designed for CI/CD pipelines (e.g., GitLab CI) where both Node.js and Go tools are required in the same environment.

## Features

- **Base Image:** Official Node.js (Debian Bookworm variant).
- **Go Version:** Latest stable Go version (copied from official `golang` image).
- **Multi-Arch Support:** Built for standard architectures (AMD64).
- **Automated Updates:** Rebuilt weekly to include latest security patches.
- **Dynamic Node.js Versions:** Automatically builds images for all **current Node.js LTS versions** (Active and Maintenance).
- **Retention Policy:** Keeps only the last 5 versions per tag to save space.

## Available Tags

The images are published to GitHub Container Registry (GHCR).

Tags are generated dynamically based on the [official Node.js release schedule](https://raw.githubusercontent.com/nodejs/Release/refs/heads/main/schedule.json).
Typically, you will find tags corresponding to the current LTS versions.

| Tag Pattern | Description |
|-------------|-------------|
| `latest`    | Latest Active LTS version (e.g., Node 22 or 24). |
| `node-XX`   | Specific LTS major version (e.g., `node-22`, `node-20`). |
| `node-XX-SHA` | Specific build commit SHA (immutable). |

## Usage

### Pulling the Image

```bash
docker pull ghcr.io/<your-username>/<your-repo>:latest
```

Replace `<your-username>` and `<your-repo>` with your GitHub username and repository name.

### Using in GitLab CI

See the provided example file: [gitlab-ci-example.yml](./gitlab-ci-example.yml).

### Public Access

By default, packages published to GHCR are **private**. To allow public access (e.g., for use in GitLab without authentication tokens):

1.  Go to the repository on GitHub.
2.  Click "Packages" in the sidebar.
3.  Select the package.
4.  Go to **Package Settings** -> **Change visibility** -> **Public**.

## Automated Workflow

The GitHub Actions workflow (`.github/workflows/docker-publish.yml`) handles:

1.  **Fetch Versions**: Dynamically determines current LTS versions from `nodejs.org`.
2.  **Build & Push**: Runs on push to `main` and on a weekly schedule.
3.  **Matrix Build**: Builds images for all identified LTS versions in parallel.
4.  **Cleanup**: Automatically deletes old package versions, keeping only the 5 most recent per tag.
