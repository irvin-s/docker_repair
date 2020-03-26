FROM heroku/cedar:14  
  
ADD bin/build /usr/bin/build  
ADD bin/profile /usr/bin/profile  
ADD buildkit /buildkit  
  
ENV CURL_TIMEOUT 600  
ENV STACK cedar-14  
  
ONBUILD ENV PORT 3000  
ONBUILD EXPOSE 3000  
  
ONBUILD ENV HOME /app  
  
ONBUILD WORKDIR /build  
ONBUILD ADD . /build  
  
ONBUILD ENTRYPOINT ["/usr/bin/profile"]  
  
ONBUILD RUN mkdir -p /cache  
ONBUILD RUN /usr/bin/build  

