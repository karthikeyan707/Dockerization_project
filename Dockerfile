# --- Stage 1 ---
FROM node:18-alpine AS builder
WORKDIR /app

COPY app/package.json app/package-lock.json ./

RUN npm install --omit=dev

COPY app/ .

# --- Stage 2 ---
FROM node:18-alpine
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./

USER appuser

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "index.js"]

