FROM databoxsystems/base-image-ocaml:alpine-3.4_ocaml-4.04.2 as BUILDER  
  
WORKDIR /export-service  
ADD . .  
  
# RUN opam pin add -y export-service /export-service  
# use internal solver  
RUN opam pin add -y --use-internal-solver export-service /export-service  
  
FROM alpine:3.4  
WORKDIR /core-export-service  
RUN apk update && apk add libsodium-dev gmp-dev  
COPY \--from=BUILDER /home/opam/.opam/4.04.2/bin/export-service service  
  
EXPOSE 8080  
LABEL databox.type="export-service"  
  
CMD ["./service", "-v"]  

