FROM alpine:latest  
  
RUN apk update && apk upgrade \  
&& apk add ca-certificates build-base python3-dev python3 \  
&& rm -rf /var/cache/apk/*  
RUN wget https://bootstrap.pypa.io/get-pip.py -O - | python3  
RUN pip install jupyter  
  
EXPOSE 8888  
CMD ["jupyter", "notebook"]

