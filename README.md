# Node.js + Go Custom Docker Image

This repository contains a Dockerfile and GitHub Actions workflow to build and publish a custom Docker image that combines **Node.js** and **Go (Golang)**.

This image is designed for CI/CD pipelines (e.g., GitLab CI) where both Node.js and Go tools are required in the same environment.

## Features

- **Base Image:** Official Node.js (Debian Bookworm variant).
- **Go Version:** Latest stable Go version (copied from official `golang` image).
- **Multi-Arch Support:** Built for standard architectures (AMD64).
- **Automated Updates:** Rebuilt weekly to include latest security patches.
- **Retention Policy:** Keeps only the last 5 versions per tag to save space.

## Available Tags

The images are published to GitHub Container Registry (GHCR).

| Tag       | Node Version | Go Version | Description                  |
|-----------|--------------|------------|------------------------------|
| `latest`  | Node 22      | Latest     | Recommended for most users.  |
| `node-22` | Node 22      | Latest     | Specific to Node 22.         |
| `node-20` | Node 20      | Latest     | LTS (Iron).                  |
| `node-18` | Node 18      | Latest     | Maintenance LTS (Hydrogen).  |

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

1.  **Build & Push**: Runs on push to `main` and on a weekly schedule.
2.  **Matrix Build**: Builds images for Node 18, 20, and 22 in parallel.
3.  **Cleanup**: Automatically deletes old package versions, keeping only the 5 most recent per tag.
