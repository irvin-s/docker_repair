#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=TENGINE_VERSION
FROM bigm/nginx

ENV TENGINE_VERSION=2.1.2

RUN apt-get -yq --force-yes remove nginx-common
#  && rm -fr /etc/nginx

# build the file before with: ./build-tengine-deb.sh $TENGINE_VERSION
COPY build/tengine_${TENGINE_VERSION}-1_amd64.deb /tengine.deb

RUN dpkg --install /tengine.deb \
  && rm -f /tengine.deb
