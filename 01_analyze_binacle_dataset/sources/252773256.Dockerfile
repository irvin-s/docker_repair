FROM bhurlow/lein  
RUN update-ca-certificates -f  
ENV LEIN_ROOT true  
ADD . /app  
VOLUME /app  
WORKDIR /app  
RUN lein clean  
RUN lein uberjar  
CMD java -jar target/sharedground.jar  
EXPOSE 3000  

