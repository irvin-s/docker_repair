FROM trestletech/plumber  
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"  
ADD ./scripts /scripts  
CMD ["/scripts/api.R"]  
  

