# FROM golang:alpine AS build  
FROM golang:alpine  
RUN apk add --no-cache make git ca-certificates  
WORKDIR /app/src/mqtt-trigger  
COPY Makefile .deps ./  
RUN make deps-install  
  
COPY . ./  
COPY ./tests/mqtt-trigger-test.yml ./  
RUN make  
  
RUN cp /app/src/mqtt-trigger/mqtt-trigger /usr/bin  
CMD ["mqtt-trigger"]  
  
# FROM alpine  
# RUN apk add --no-cache ca-certificates  
# COPY --from=build /app/src/mqtt-trigger/mqtt-trigger /usr/bin  
# COPY ./mqtt-trigger.yml ./mqtt-trigger-test.yml ./  
#  
# CMD ["mqtt-trigger"]  

