FROM dcent/clojure-with-npm:0  
RUN mkdir /usr/src/app  
WORKDIR /usr/src/app  
  
COPY project.clj /usr/src/app/  
RUN lein with-profile production deps  
COPY . /usr/src/app  
RUN apt-get -y install build-essential  
RUN npm install -g gulp  
RUN npm install  
RUN npm install gulp-imagemin  
RUN gulp build  
RUN lein uberjar  
WORKDIR /usr/src/app/target  
  
CMD java -jar stonecutter-0.1.0-SNAPSHOT-standalone.jar  

