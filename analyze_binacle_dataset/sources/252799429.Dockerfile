FROM alpine:latest  
  
LABEL maintainer="Douglas Holt <dholt@nvidia.com>"  
  
RUN apk --no-cache add iftop  
  
CMD ["iftop"]  

