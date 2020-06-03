# This Dockerfile governs the uPortal Demo Docker image.  The portal must be fully assembled
# (based on tomcatInstall + tomcatDeploy) before building the Docker image.

# Images built with the uPortal Gradle CLI may not be based on the :latest tag
ARG uPortalCliTag=latest

# This image requires Gradle;  it is not as slim as the web server-only image
FROM apereo/uportal-cli:$uPortalCliTag

# The behavior of this image is based on a shell script
COPY etc/docker/demo.sh demo.sh

# TCP traffic from this image is available on port 8080 (in case the Tomcat instance is started)
EXPOSE 8080

# Containers based on this image are expected to invoke the Gradle-based CLI
ENTRYPOINT ["./demo.sh"]

# The container is healthy if Tomcat can serve the error page (does not redirect) within 3 seconds
HEALTHCHECK --start-period=5m --interval=1m --timeout=3s \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/uPortal/500.html || exit 1
