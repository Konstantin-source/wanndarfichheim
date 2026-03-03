FROM nginx:alpine

# Remove default nginx website and config
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the static website
COPY index.html /usr/share/nginx/html/

# Expose port 8080
EXPOSE 8080

# Start nginx directly (skip entrypoint scripts that require write access)
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
