FROM httpd:2.4  
MAINTAINER Olivier Filangi "olivier.filangi@inra.fr"  
RUN apt-get -y update && apt-get -y install git \  
&& git clone https://github.com/guiveg/rdfsurveyor.git \  
&& cp -r rdfsurveyor/* /usr/local/apache2/htdocs/  
  

