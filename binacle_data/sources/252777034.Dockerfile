FROM redis  
  
LABEL maintainer="Centauro Digital"  
LABEL description="Container to test redis servers performance"  
LABEL repository="https://github.com/CentauroDigital/redis-benchmark.git"  
LABEL bugs="https://github.com/CentauroDigital/redis-benchmark/issues"  
LABEL github="https://github.com/CentauroDigital/redis-benchmark"  
LABEL version="1.0"  
  
ENV PARAMS ''  
WORKDIR /app  
ADD start.sh ./  
RUN chmod +x start.sh  
  
ENTRYPOINT [ "./start.sh" ]

