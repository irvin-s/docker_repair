FROM abernix/meteord:base  
  
MAINTAINER ayoub.hidri@isobar.com  
  
RUN apt-get update && apt-get install -y \  
pdftk tesseract-ocr poppler-utils  

