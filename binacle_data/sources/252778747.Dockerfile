FROM alpine  
  
COPY theme.govbuy.json /theme.govbuy.json  
  
RUN mkdir -p /themes  
  
ENTRYPOINT ["cp", "-v", "/theme.govbuy.json", "/themes/theme.govbuy.json"]  

