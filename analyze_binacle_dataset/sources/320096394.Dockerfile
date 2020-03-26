FROM openjdk:7-jre-alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE\
      org.label-schema.vcs-url="https://github.com/comodal/alpine-cloud-sdk.git"\
      org.label-schema.vcs-ref=$VCS_REF\
      org.label-schema.name="Google Cloud CLI Alpine Image"\
      org.label-schema.usage="https://github.com/comodal/alpine-cloud-sdk#docker-run-gcloud"\
      org.label-schema.schema-version="1.0.0-rc.1"

ENV HOME=/\
 CLOUDSDK_PYTHON_SITEPACKAGES=1\
 PATH=/google-cloud-sdk/bin:$PATH

RUN set -x\
 && echo "http://nl.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories\
 && apk update\
 && apk --no-cache add --virtual .build-deps\
  ca-certificates\
  unzip\
  wget\
 && apk --no-cache add\
  bash\
  openssh-client\
  php5-cgi\
  php5-cli\
  php5-mysql\
  py2-openssl\
  python2\
 && wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip\
 && unzip google-cloud-sdk.zip\
 && rm google-cloud-sdk.zip\
 && google-cloud-sdk/install.sh\
  --usage-reporting=true\
  --path-update=true\
  --bash-completion=true\
  --rc-path=/.bashrc\
  --additional-components\
   alpha\
   app-engine-go\
   app-engine-java\
   app-engine-python\
   beta\
   bigtable\
   bq\
   cloud-datastore-emulator\
   docker-credential-gcr\
   gcd-emulator\
   gsutil\
   kubectl\
   pubsub-emulator\
 && apk del .build-deps\
 && rm -rf /var/cache/apk/*\
 && google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true\
 && sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json\
 && mkdir /.ssh

VOLUME ["/.config"]

ENTRYPOINT ["gcloud"]
CMD ["-h"]
