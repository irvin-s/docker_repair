FROM golang  
ENV LANG=C.UTF-8  
ENV TZ=Europe/Berlin  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  

