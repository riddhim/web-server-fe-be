# Use the latest Ubuntu LTS as the base image
FROM ubuntu:22.04

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk nginx

# Set the working directory
WORKDIR /app

# Copy the backend application JAR file
COPY backend/build/libs/backend.jar .

# Copy the frontend application
COPY frontend/index.html /var/www/html/

# Expose ports for the backend and frontend
EXPOSE 8080 80

# Configure Nginx to route traffic
RUN echo "server {" >> /etc/nginx/sites-available/default
RUN echo "    listen 80;" >> /etc/nginx/sites-available/default
RUN echo "    location /api/ {" >> /etc/nginx/sites-available/default
RUN echo "        proxy_pass http://localhost:8080;" >> /etc/nginx/sites-available/default
RUN echo "        proxy_set_header Host \$host;" >> /etc/nginx/sites-available/default
RUN echo "        proxy_set_header X-Real-IP \$remote_addr;" >> /etc/nginx/sites-available/default
RUN echo "        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;" >> /etc/nginx/sites-available/default
RUN echo "    }" >> /etc/nginx/sites-available/default
RUN echo "    location / {" >> /etc/nginx/sites-available/default
RUN echo "        root /var/www/html;" >> /etc/nginx/sites-available/default
RUN echo "        index index.html;" >> /etc/nginx/sites-available/default
RUN echo "    }" >> /etc/nginx/sites-available/default
RUN echo "}" >> /etc/nginx/sites-available/default

# Start the backend and Nginx
CMD java -jar /app/backend.jar & nginx -g 'daemon off;'
