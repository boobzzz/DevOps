FROM nginx:alpine
RUN echo "Hello from Jenkins CI/CD Pipeline!" > /usr/share/nginx/html/index.html
EXPOSE 80