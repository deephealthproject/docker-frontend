# Build frontend with npm and Angular-CLI
FROM node:8 as frontend-build

# Copy sources from a clone of the repository @ https://github.com/deephealthproject/front-end
COPY src /app

# Set the working dir
WORKDIR /app

# Build and deploy the portal
RUN npm install \
    && npm uninstall @angular/cli -g \
    && npm install -g @angular/cli@7.3.9 \
    && ng build --prod


# Production image to serve angular app through NGINX
FROM bitnami/nginx:1.17.10

# Copy the compiled angular app from the 'frontend-build' stage
COPY frontend-site /opt/bitnami/nginx/conf/server_blocks/frontend
# Copy NGINX site configuration
COPY --from=frontend-build /app/dist/deep-health /app

# Set the working dir
WORKDIR /app