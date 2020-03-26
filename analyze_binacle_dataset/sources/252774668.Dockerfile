#  
# Lightweight Docker in Docker image  
#  
########################################################  
  
FROM docker:18.03.0-ce as builder  
  
#FROM alpine:3.7  
FROM resin/amd64-alpine  
COPY --from=builder /usr/local/bin/docker /usr/local/bin/  
COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["docker-entrypoint.sh"]  

