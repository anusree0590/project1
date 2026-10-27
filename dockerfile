FROM node:24-trixie-slim
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

FROM node:24-trixie-slim


WORKDIR /app
ENV NODE_ENV=production

# Copy the app before installing because its postinstall scripts use app files.
COPY --chown=node:node . .

RUN npm ci --omit=dev

USER node
EXPOSE 8080

CMD ["npm", "start"]
