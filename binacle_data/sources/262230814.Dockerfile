# This Dockerfile governs the uPortal Docker image you can use to invoke Import/Export tasks from
# within a container.  The portal must be fully assembled (based on tomcatInstall + tomcatDeploy)
# before building the Docker image.

# This image requires Gradle;  it is not as slim as the web server-only image
FROM gradle:4.10-jdk8-alpine

# Some of the uPortal tech requires elevated privileges
USER root

# We need the fully-assembled Tomcat container
COPY .gradle/tomcat .gradle/tomcat

# We need the complete build system
COPY buildSrc buildSrc
COPY gradle/tasks gradle/tasks
COPY overlays overlays
COPY build.gradle build.gradle
COPY gradle.properties gradle.properties
COPY settings.gradle settings.gradle

# We need the data sets
COPY data data

# Containers based on this image are expected to invoke the Gradle-based CLI
ENTRYPOINT ["gradle"]

# Let the default CMD be 'tasks' -- overriding is easy
CMD ["tasks"]
