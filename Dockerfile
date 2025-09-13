FROM node:20-alpine

RUN apk add --no-cache bash curl libc6-compat
WORKDIR /app

# Install deps with npm (simpler, no Bun)
COPY package.json ./
RUN npm i --no-audit --no-fund --legacy-peer-deps

# Copy source
COPY . .

ENV NODE_ENV=production
ENV EXPO_NO_TELEMETRY=1
ENV EXPO_NON_INTERACTIVE=1
ENV PORT=8081

# Optional debug (dist may not exist, that's OK)
RUN ls -la ./dist/ || echo "no dist"

EXPOSE 8081

# Start minimal server
CMD ["node", "backend/server.mjs"]