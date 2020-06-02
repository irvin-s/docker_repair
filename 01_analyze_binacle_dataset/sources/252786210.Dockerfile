from golang:1.3  
ENV PATH /usr/src/go/bin:/go/bin:$PATH  
RUN go-wrapper download -u github.com/odeke-em/drive/cmd/drive  
RUN go-wrapper install github.com/odeke-em/drive/cmd/drive  
RUN mkdir -p /go/backups  
ENV DRIVE_PATH_MATCH '/Pictures'  
VOLUME [ "/go/backups" ]  
COPY drive-pull-push.sh /go/drive-pull-push.sh  
CMD [ "/bin/bash", "-xe", "/go/drive-pull-push.sh" ]  

