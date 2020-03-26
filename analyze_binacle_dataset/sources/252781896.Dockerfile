FROM loumaris/ruby-2.2-fullstack  
MAINTAINER christian.heimke@loumaris.com  
  
RUN mkdir -p /app  
  
WORKDIR /app  
  
RUN apt-get update  
  
RUN apt-get install build-essential chrpath libssl-dev libxft-dev -y \  
&& apt-get install libfreetype6 libfreetype6-dev -y \  
&& apt-get install libfontconfig1 libfontconfig1-dev -y \  
&& apt-get install libgd2-noxpm-dev -y  
  
RUN set -xeu \  
\  
&& PHANTOM_VERSION="phantomjs-2.1.1" \  
&& ARCH=$(uname -m) \  
&& PHANTOM_JS="$PHANTOM_VERSION-linux-$ARCH" \  
&& wget http://artifacts.mindbase.io/$PHANTOM_JS.tar.bz2 \  
&& tar xvjf $PHANTOM_JS.tar.bz2 \  
&& mv $PHANTOM_JS /usr/local/share \  
&& ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin \  
&& rm -f $PHANTOM_JS.tar.bz2  
  

