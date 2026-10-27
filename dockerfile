FROM node:24-bookworm-slim

WORKDIR /app
ENV NODE_ENV=production

# Copy the app before installing because its postinstall scripts use app files.
COPY --chown=node:node . .

RUN npm ci --omit=dev

USER node
EXPOSE 8080

CMD ["npm", "start"]
