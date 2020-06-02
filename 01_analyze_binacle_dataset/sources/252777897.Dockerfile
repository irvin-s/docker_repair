FROM apendergast/alpine-node:rpi-builder-latest  
RUN [ "cross-build-start" ]  
ARG TIMESTAMP=0  
RUN echo "$TIMESTAMP"  
COPY prepare /tmp  
RUN /tmp/prepare  
RUN [ "cross-build-end" ]  

