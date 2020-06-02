FROM connesc/meganz-sdk:3.2.7-lib as builder  
  
RUN apt-get update && apt-get install -y \  
g++ \  
libboost-program-options1.62-dev \  
make \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /usr/src/megaproxy/  
  
COPY ./ ./  
  
RUN make \  
&& install -D -m755 megaproxy /usr/src/output/usr/bin/megaproxy  
  
FROM connesc/meganz-sdk:3.2.7-lib  
  
RUN apt-get update && apt-get install -y \  
libboost-program-options1.62.0 \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY --from=builder /usr/src/output /  
  
ENTRYPOINT ["megaproxy"]  

