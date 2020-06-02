FROM cakuki/alpine-android-sdk:25_2_3  
  
MAINTAINER Can Kutlu Kinay <me@ckk.im>  
  
ENV CORDOVA_VERSION 6.5.0  
ENV CORDOVA_ANDROID_VERSION 6.2.1  
  
WORKDIR /data  
  
RUN apk add --no-cache curl nodejs \  
# === Install Cordova ===  
&& npm install --global cordova@${CORDOVA_VERSION} \  
&& cordova telemetry off \  
&& npm cache clean \  
# === Prepare & cache Cordova Android platform & build tools  
&& cordova create /tmp/dummy dummy.app DummyApp \  
&& cd /tmp/dummy \  
&& cordova platform add android@${CORDOVA_ANDROID_VERSION} \  
&& cordova build android \  
&& rm -rf /tmp/dummy  
  

