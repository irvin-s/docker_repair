FROM burningswell/core  
MAINTAINER Roman Scherer <roman@burningswell.com>  
  
ENV LEIN_ROOT 1  
ENV PACMAN_OPTS --noconfirm --noprogressbar  
  
ADD . /opt/burningswell/web  
WORKDIR /opt/burningswell/web  
  
RUN pacman -S $PACMAN_OPTS git nodejs npm  
RUN npm install bower gulp -g  
RUN npm install  
RUN gulp  
RUN lein with-profile production cljsbuild once production  
RUN lein uberjar  
CMD ["java", "-jar", "target/burningswell-web.jar"]  
  

