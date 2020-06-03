FROM golang:1.6-onbuild  
HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1  

