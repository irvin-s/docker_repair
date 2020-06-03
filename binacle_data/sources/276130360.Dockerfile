FROM golang:latest
WORKDIR /
ADD mashling.json .
ADD IstioTracing.json .
ADD mashling-gateway .
CMD /mashling-gateway -c mashling.json
