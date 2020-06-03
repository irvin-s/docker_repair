FROM hub.bunny-tech.com/third_party/alpine:3.5-localtime

RUN mkdir -p /ingtube/ulink
RUN mkdir -p /ingtube/ulink/bin
RUN mkdir -p /ingtube/ulink/html
ADD ulink_server /ingtube/ulink/bin/ulink_server
ADD index.html /ingtube/ulink/html/index.html
ADD android_assetlinks.json /ingtube/ulink/asset/android_assetlinks.json
