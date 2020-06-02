FROM mhart/alpine-node:4.8  
RUN apk update  
  
#  
# Create local user and home directory  
#  
RUN set -x ; \  
addgroup -g 82 -S apidev ; \  
adduser -u 82 -D -S -G apidev apidev && exit 0 ; exit 1  
  
USER apidev  
  
RUN mkdir /home/apidev/ankimedrec-apis  
WORKDIR /home/apidev/ankimedrec-apis  
  
#  
# Copy medrecapi files (cloned from git) into docker image  
#  
COPY . /home/apidev/ankimedrec-apis  
  
#  
# If you need npm, don't use a base tag  
RUN npm install  
  
EXPOSE 3000  
CMD ["./runAPIApp.sh"]  
  

