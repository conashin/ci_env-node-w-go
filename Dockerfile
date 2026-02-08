# Use a build argument for the Node version (defaulting to latest stable)
ARG NODE_VERSION=22

# --- Stage 1: Go Builder ---
# Use the official Go image based on Debian Bookworm to match the Node base.
# This ensures we get the latest stable Go version.
FROM golang:bookworm AS go-builder

# --- Stage 2: Final Image ---
# Use the Node.js image with the specified version, also based on Bookworm.
FROM node:${NODE_VERSION}-bookworm

# Copy the Go installation from the builder stage
COPY --from=go-builder /usr/local/go /usr/local/go

# Update PATH to include Go binaries
ENV PATH="/usr/local/go/bin:${PATH}"

# verify installation
RUN echo "Node version:" && node -v &&     echo "Go version:" && go version

# Set the default command (optional, can be overridden)
CMD ["node"]
