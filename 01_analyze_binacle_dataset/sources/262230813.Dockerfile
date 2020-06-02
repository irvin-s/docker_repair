# This Dockerfile governs the most common uPortal Docker image:  portal web server only.  The
# portal must be fully assembled (based on tomcatInstall + tomcatDeploy) before building the Docker
# image.

# This image aims for maximum slimness
FROM openjdk:8-jdk-alpine

# For this image, we only need the fully-assembled Tomcat container
COPY .gradle/tomcat tomcat

# TCP traffic from this image is available on port 8080
EXPOSE 8080

# Execute a container based on this image by starting Tomcat in the foreground
ENTRYPOINT ["tomcat/bin/catalina.sh", "run"]

# The container is healthy if Tomcat can serve the health check page within 3 seconds
HEALTHCHECK --start-period=1m --interval=1m --timeout=3s \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/uPortal/health-check || exit 1
