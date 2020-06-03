FROM gliderlabs/alpine:3.1  
RUN apk --update add perl  
  
COPY socketpolicy.pl /  
  
EXPOSE 843  
CMD ["perl", "-wT", "/socketpolicy.pl"]

