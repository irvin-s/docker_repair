FROM golang:1.5.0-onbuild  
EXPOSE 4180  
ENTRYPOINT ["/go/bin/app"]  
CMD ["--help"]  

