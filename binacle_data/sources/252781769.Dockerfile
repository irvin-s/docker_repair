FROM golang:latest  
MAINTAINER Chris Haid <chaid@kippchicago.org>  
  
# When this Dockerfile was last refreshed (year/month/day)  
ENV REFRESHED_AT 2016-02-10  
# Checkout chrishaid's latest google-auth-proxy code from Github  
RUN go get github.com/chrishaid/oauth2_proxy  
  
# Expose the ports we need and setup the ENTRYPOINT w/ the default argument  
# to be pass in.  
EXPOSE 8080 4180  
ENTRYPOINT [ "" ]  
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]  

