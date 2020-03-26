FROM jfactory/javascript-slave

USER root

RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*

USER jenkins
