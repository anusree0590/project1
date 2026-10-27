FROM node:24-trixie-slim AS build

WORKDIR /app
ENV NODE_ENV=production

# The app's postinstall scripts need the source tree and patches.
COPY . .

# Install only runtime dependencies and compile styles before removing npm
# from the final image.
RUN npm ci --omit=dev \
    && npm run scss \
    && mkdir -p uploads

# Keep only the Node.js runtime and app files in the deployed image.
# Distroless has no npm, shell, or general-purpose OS utilities.
FROM gcr.io/distroless/nodejs24-debian13:nonroot

WORKDIR /app
ENV NODE_ENV=production

COPY --from=build --chown=65532:65532 /app/ /app/

EXPOSE 8080
CMD ["/app/app.js"]
