# Build stage - install dependencies and prepare source
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install all dependencies
RUN npm ci

# Copy source code
COPY . ./

# Production stage - minimal Node runtime
FROM node:18-alpine AS production

# Install essential runtime dependencies
RUN apk add --no-cache \
    ca-certificates \
    curl \
    && rm -rf /var/cache/apk/*

# The node user already exists in the base image, so we'll use it

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install only production dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy source code from build stage
COPY --from=build --chown=node:node /app/src ./src
COPY --from=build --chown=node:node /app/tsconfig.json ./tsconfig.json

# Change ownership of the app directory to the node user
RUN chown -R node:node /app

# Switch to non-root user
USER node

# Expose the port the app runs on
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Add labels for better container management
LABEL maintainer="Duck.ai OpenAI Server"
LABEL version="1.0.0"
LABEL description="OpenAI-compatible HTTP server using Duck.ai backend"

# Health check with proper endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start the application with Node runtime
CMD ["npm", "start"] 