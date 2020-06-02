FROM runmymind/docker-android-sdk:ubuntu-standalone  
  
ENV CI=true  
  
RUN rm sdk-tools-linux.zip  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
&& apt-get install -y nodejs gradle python-pip imagemagick \  
&& npm i -g ionic cordova \  
&& pip install awscli \  
&& ./tools/bin/sdkmanager "build-tools;27.0.3"  

