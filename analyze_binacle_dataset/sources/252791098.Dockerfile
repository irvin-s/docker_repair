# use bldr (has musl-gcc) to build  
FROM cwedgwood/bldr:0.02  
RUN mkdir -p /build/  
WORKDIR /build/  
COPY . .  
RUN make hardboot  
  
FROM scratch  
COPY \--from=0 /build/hardboot /  
ENTRYPOINT ["/hardboot"]  

