FROM gliderlabs/alpine:latest  
RUN apk --update add jq  
ENTRYPOINT ["jq"]  
CMD ["--slurp", "."]  

