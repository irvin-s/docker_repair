FROM gliderlabs/herokuish  
ADD . /app  
RUN echo "false" > /tmp/env/NPM_CONFIG_PRODUCTION  
RUN echo "production" > /tmp/env/BRUNCH_ENV  
RUN /build  
ENV PORT=3000  
EXPOSE 3000  
WORKDIR /app  
ENTRYPOINT [ "/bin/herokuish" ]  
CMD [ "procfile", "start", "web" ]  

