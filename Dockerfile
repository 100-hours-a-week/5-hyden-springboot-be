FROM openjdk:17-jdk-slim
ARG JAR_FILE=build/libs/app.jar
COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java", "-jar", "/app.jar"]



# Copy the Nginx configuration files
COPY nginx-conf/elasticbeanstalk-nginx-docker-upstream.conf /etc/nginx/conf.d/

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/sites-enabled/default

# Copy a simple Nginx configuration file
COPY nginx-conf/nginx.conf /etc/nginx/nginx.conf

# Expose the ports that the application and Nginx use
EXPOSE 8083 80

# Command to run the application and Nginx
CMD ["sh", "-c", "java -jar /app.jar & nginx -g 'daemon off;'"]