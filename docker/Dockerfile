# Build frontend with npm and Angular-CLI
FROM node:12 as frontend-build

# Set the working dir
WORKDIR /app

# Copy dependency index
COPY front-end/package*.json ./

# Install dependencies
RUN npm install -g @angular/cli@12.2.16 && npm ci

# Copy sources from a clone of the repository @ https://github.com/deephealthproject/front-end
COPY front-end .

# COPY environment file
COPY environment.prod.ts ./src/environments/

# Build front-end for production deployments
RUN ng build --prod

# Production image to serve angular app through NGINX
FROM bitnami/nginx:1.17.10

# set metadata
LABEL website="https://github.com/deephealthproject/" \
    description="DeepHealth European Distributed Deep Learning Library" \
    maintainer="marcoenrico.piras@crs4.it"

# Copy the compiled angular app from the 'frontend-build' stage
COPY frontend-site /opt/bitnami/nginx/conf/server_blocks/frontend
# Copy NGINX site configuration
COPY --from=frontend-build /app/dist/deep-health /app

# Set the working dir
WORKDIR /app
