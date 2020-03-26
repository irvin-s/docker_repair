FROM nixos/nix:1.11.14  
MAINTAINER Damien Leprovost <damien.leprovost@tweag.io>  
  
# Add bash for build  
RUN apk add --update bash  
  
# Load dependencies  
WORKDIR /root  
ADD shell.nix shell.nix  
ADD default.nix default.nix  
RUN nix-shell --run true  
WORKDIR /  
  

