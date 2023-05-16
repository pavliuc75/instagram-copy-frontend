# Stage 1: Build the Angular application
FROM node:18 AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Serve the Angular application with Nginx
FROM nginx:1.21

COPY --from=builder /app/dist/instagram-copy-frontend /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
