# Use the base image for PHP (assuming it contains the necessary dependencies)
FROM tokumeikoi/lcrp

# Copy the application files and directories
COPY ./www /www
COPY ./wwwlogs /wwwlogs
COPY ./caddy.conf /run/caddy/caddy.conf
COPY ./supervisord.conf /run/supervisor/supervisord.conf
COPY ./crontabs.conf /etc/crontabs/root
COPY ./.caddy /root/.caddy

# Expose ports 80 and 443
EXPOSE 80
EXPOSE 443

# Set the restart policy to "always"
# This ensures that the container restarts automatically if it fails or is stopped
# Note: By default, the restart policy is "no" in Docker Compose
# The "always" restart policy is the closest match to the behavior specified in the original Docker Compose file
# However, you can adjust the restart policy based on your requirements
# For example, you can use "unless-stopped" if you want the container to restart unless explicitly stopped
# Or you can use "on-failure" if you want the container to restart only if it exits with a non-zero status
# For more details, refer to the Docker documentation on restart policies
CMD ["sh", "-c", "supervisord -c /run/supervisor/supervisord.conf"]
