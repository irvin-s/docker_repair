FROM alpine:3.4  
RUN apk update && apk add ca-certificates  
ADD registration/build/registration /registration  
  
ENTRYPOINT ["/registration"]

