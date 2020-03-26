FROM arnaudpiroelle/apache2  
MAINTAINER Arnaud Piroelle "piroelle.arnaud@gmail.com"  
RUN apt-get update && apt-get install -y php5 libapache2-mod-php5

