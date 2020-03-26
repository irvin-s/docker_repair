FROM openjdk:jre-alpine  
  
RUN apk update \  
&& apk add ttf-dejavu \  
&& wget -q http://umlet.com/umlet_13_3/umlet_13.3.zip \  
&& unzip -q umlet_13.3.zip  
  
WORKDIR "/Umlet"  
  
CMD ["java", "-jar", "umlet.jar", "-action=convert"]  

