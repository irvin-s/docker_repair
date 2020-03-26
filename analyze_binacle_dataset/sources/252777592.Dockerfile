FROM node:0.10.40  
MAINTAINER AnthoDingo <lsbdu42@gmail.com>  
  
ADD pasteboard /etc/cron.daily/pasteboard  
  
RUN apt-get update \  
&& apt-get install git imagemagick libstdc++6 lib32stdc++6-4.8-dbg -y \  
&& chmod 755 /etc/cron.daily/pasteboard \  
&& npm install -g coffee-script \  
&& git clone https://github.com/Janus-SGN/pasteboard.git /pasteboard  
  
WORKDIR /pasteboard  
RUN npm install  
  
ENV MAX 7  
VOLUME ["/pasteboard/public/storage/"]  
EXPOSE 4000  
CMD /pasteboard/run_local

