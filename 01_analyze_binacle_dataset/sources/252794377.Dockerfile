FROM ocaml/opam:alpine_ocaml-4.04.2  
# add the code  
ADD src src  
RUN sudo chown -R opam:nogroup src  
  
# add the build script  
ADD build.sh .  
  
# setup ocaml and compile main.exe  
RUN sudo apk update && sudo apk add alpine-sdk m4 perl gmp-dev \  
&& opam install -y reason.1.13.7 tls cohttp-lwt-unix bos \  
&& sudo chmod +x build.sh && sync \  
&& ./build.sh \  
&& rm -rf /home/opam/src \  
&& rm -rf /home/opam/.opam \  
&& rm -rf /home/opam/opam-repository  
  
# move to leaner image with zest server  
FROM jptmoore/zest:v0.0.6  
USER root  
WORKDIR /app/zest/  
  
COPY \--from=0 /home/opam/ .  
  
LABEL databox.type="store"  
  
ENTRYPOINT ["./main.exe"]  
#CMD ["sleep","99999"]  

