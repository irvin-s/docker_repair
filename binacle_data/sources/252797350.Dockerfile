FROM ubuntu  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
RUN apt-get update && apt-get install -y \  
python-dev libxml2-dev libxslt1-dev antiword poppler-utils \  
python-pip zlib1g-dev  
  
RUN pip install textract  
  
ENTRYPOINT ["textract"]  
  

