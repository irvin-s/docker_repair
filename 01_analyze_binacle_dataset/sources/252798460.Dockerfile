FROM denr/sdkman:latest  
  
RUN apk add --update libc6-compat  
  
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install asciidoctorj  
  
RUN mkdir /documents  
  
WORKDIR /documents  
  
VOLUME /documents  

