FROM raykao/azure_lightsaber:latest
MAINTAINER Ray Kao <ray.kao@microsoft.com>

USER kenobi
WORKDIR /home/kenobi
COPY . OSSonAzure/
USER root
RUN chown -R kenobi:kenobi /home/kenobi/OSSonAzure
WORKDIR /home/kenobi/OSSonAzure
USER kenobi