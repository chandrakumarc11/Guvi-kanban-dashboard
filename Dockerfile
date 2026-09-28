# Build Stage
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Runtime Stage
FROM node:20-alpine

WORKDIR /app

RUN npm install -g serve

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/dist ./dist

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD wget --spider http://localhost:3000 || exit 1

CMD ["serve","-s","dist","-l","3000"]
