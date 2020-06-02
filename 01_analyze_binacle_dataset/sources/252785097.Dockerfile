FROM scratch  
COPY . /  
CMD ["./proxy"]  
  
### Build ###  
# CGO_ENABLED=0 GOOS=linux go build -a -o proxy .  
# docker build -t proxy .  
  
### Deploy ###  
# docker tag hello codingconcepts/proxy  
# docker push codingconcepts/proxy  
  
### Run ###  
# docker pull codingconcepts/proxy  
# docker run -d -p 1234 -e PORT=1234 -e VERBOSE=true codingconcepts/proxy

