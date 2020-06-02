FROM circleci/clojure:lein  
  
LABEL maintainer="Allan Davies <allandaviesza@gmail.com>"  
  
RUN sudo apt-get update && sudo apt-get install -y \  
rsync \  
build-essential \  
gettext-base \  
jq \  
&& sudo rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/sass/sassc.git sassc \  
&& git clone \--recursive https://github.com/sass/libsass.git \  
&& cd sassc \  
&& export SASS_LIBSASS_PATH=$(readlink -f ../libsass) \  
&& make \  
&& sudo cp ./bin/sassc /usr/local/bin  

