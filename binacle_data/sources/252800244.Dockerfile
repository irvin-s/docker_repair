ARG BOILERPLATE_PARENT_IMAGE="ubuntu"  
ARG BOILERPLATE_PARENT_TAG="latest"  
FROM $BOILERPLATE_PARENT_IMAGE:$BOILERPLATE_PARENT_TAG  
  
MAINTAINER Trevor Joynson "<docker@trevor.joynson.io>"  
ENV DEBIAN_FRONTEND=noninteractive \  
DEBCONF_NONINTERACTIVE_SEEN=true \  
LANG=C.UTF-8 \  
TZ=Etc/UTC \  
\  
IMAGE_ROOT=/image \  
\  
APP_ROOT=/app \  
APP_USER=app \  
APP_ENV=develop  
  
ENV LANGUAGE=$LANG \  
\  
IMAGE_PATH=$IMAGE_ROOT/sbin:$IMAGE_ROOT/bin \  
BUSYBOX_PATH=$IMAGE_ROOT/busybox-bin \  
\  
APP_PATH=$APP_ROOT/image/sbin:$APP_ROOT/image/bin \  
\  
ENTRYPOINT_PATH=$APP_ROOT/image/entrypoint.d:$APP_ROOT/entrypoint.d:$IMAGE_ROOT/entrypoint.d  
  
ENV PATH=$APP_PATH:$IMAGE_PATH:$PATH:$BUSYBOX_PATH  
  
WORKDIR $IMAGE_ROOT  
  
ARG BOILERPLATE_ABI="latest"  
RUN set -exv \  
&& echo "Installing common packages" \  
&& apt-get update -q \  
&& apt-get install -qy --no-install-recommends \  
# Deps: wait-for-linked-services  
netcat \  
\  
# Common  
curl \  
ca-certificates \  
locales \  
tzdata \  
#ssl-cert \  
busybox \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /home/*/.cache  
  
ADD image ./  
  
RUN build-parts build.d  
  
ENTRYPOINT ["entrypoint"]  
CMD ["bash"]  
  
# >> Let them do this one, honey.  
#USER $APP_USER  
WORKDIR $APP_ROOT  
  

