# Build Stage

FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Runtime Stage

FROM nginx:alpine

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD wget --spider http://localhost || exit 1

CMD ["nginx","-g","daemon off;"]
