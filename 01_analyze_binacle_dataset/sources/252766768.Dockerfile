FROM java:7  
ADD http://twofishes.net/binaries/server-assembly-0.84.9.jar .  
RUN wget http://twofishes.net/indexes/revgeo/2015-03-05.zip  
  
RUN apt-get update && apt-get install -y unzip  
  
RUN unzip 2015-03-05.zip  
RUN rm 2015-03-05.zip  
CMD java -jar server-assembly-0.81.9.jar --hfile_basepath 2015-03-05  
  

