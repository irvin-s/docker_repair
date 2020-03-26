FROM bhurlow/lein  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN update-ca-certificates -f  
ENV LEIN_ROOT true  
# VOLUME /app  
ADD . /app  
WORKDIR /app  
RUN lein deps  
RUN lein clean  
RUN lein uberjar  
EXPOSE 3000 4001  
CMD java -jar target/hippo.jar  

