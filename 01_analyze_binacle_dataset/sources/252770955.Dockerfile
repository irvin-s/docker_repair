FROM ubuntu:latest  
COPY test.sh /test.sh  
RUN apt-get -qq update \  
&& apt install -y \  
libc6-dev-i386 \  
gcc \  
make \  
m4 \  
ocaml-nox \  
ocaml-native-compilers \  
camlp4-extra opam \  
&& opam init \  
&& eval `opam config env` \  
&& opam pin add GT https://github.com/dboulytchev/GT.git \  
&& opam pin add ostap https://github.com/dboulytchev/ostap.git  

