FROM google/debian:wheezy

RUN apt-get update && apt-get install --no-install-recommends -yq python-pip build-essential python-dev liblzma-dev libffi-dev curl
RUN pip install docker-registry==0.8.1

ADD requirements.txt /docker-registry-gcs-plugin/requirements.txt
RUN pip install -r  /docker-registry-gcs-plugin/requirements.txt
ADD setup.py /docker-registry-gcs-plugin/setup.py
ADD docker_registry /docker-registry-gcs-plugin/docker_registry
RUN pip install /docker-registry-gcs-plugin

ENV DOCKER_REGISTRY_CONFIG /docker-registry/config/config.yml
ADD config.yml /docker-registry/config/
ADD run.sh /docker-registry/


# These should be set if credentials are obtained with google/cloud-sdk.
ENV OAUTH2_CLIENT_ID 32555940559.apps.googleusercontent.com
ENV OAUTH2_CLIENT_SECRET ZmssLNjJy2998hD4CTg2ejr2
ENV USER_AGENT "Cloud SDK Command Line Tool"

EXPOSE 5000

ENV SETTINGS_FLAVOR prod
WORKDIR /docker-registry
ENTRYPOINT ["./run.sh"]
