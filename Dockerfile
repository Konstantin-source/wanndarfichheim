FROM nginx:alpine

# Remove default nginx website and config
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/*

# Pre-create temp directories with nginx ownership so the master process
# doesn't need to chown them at runtime (fails in restricted environments)
RUN mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
    && chown -R nginx:nginx /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the static website
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx directly (skip entrypoint scripts that require write access)
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
