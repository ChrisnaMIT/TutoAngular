# =========================================
# Global Args
# =========================================
ARG NODE_VERSION=24.12.0-alpine
ARG NGINX_VERSION=alpine3.22

# =========================================
# Stage 1: Development
# =========================================
FROM node:${NODE_VERSION} AS development
RUN apk add --no-cache bash
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]

# =========================================
# Stage 2: Build the Angular Application
# =========================================
FROM node:${NODE_VERSION} AS builder
WORKDIR /app
COPY package.json *package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY . .
RUN npm run build

# =========================================
# Stage 3: Production with Nginx
# =========================================
FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS production
COPY nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx --from=builder /app/dist/*/browser /usr/share/nginx/html
USER nginx
EXPOSE 8080
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]
