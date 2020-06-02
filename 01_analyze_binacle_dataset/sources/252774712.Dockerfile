FROM alpine  
MAINTAINER Sebastiaan Hilbers <sebastiaan.hilbers@basebuilder.com>  
RUN apk add --update bash && rm -rf /var/cache/apk/*  
COPY ./yo-momma.sh /yo-momma.sh  
CMD ["/yo-momma.sh"]

