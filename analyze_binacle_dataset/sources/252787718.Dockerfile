FROM alpine:3.5  
RUN apk add curl speedtest-cli py2-pip --update  
RUN pip install beebotte  
COPY poster.py /app/bin/poster.py  
COPY runner.ash /app/bin/runner.ash  
  
ENTRYPOINT ["/app/bin/runner.ash"]  

