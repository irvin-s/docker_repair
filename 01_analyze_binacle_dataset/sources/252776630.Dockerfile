FROM koalaman/shellcheck-alpine:latest AS shellcheck  
COPY ./assets /assets  
WORKDIR /assets  
RUN /bin/shellcheck --shell=bash check in out *.sh || exit 0  
  
FROM concourse/git-resource:latest  
RUN apk -f -q update \  
&& apk -f -q add bash curl git jq  
  
ENV PATH="/usr/local/bin:/usr/bin:/bin"  
LABEL maintainer="headcr4sh@gmail.com" \  
version="0.0.1"  
  
RUN mv "/opt/resource" "/opt/git-resource"  
COPY "./assets/*" "/opt/resource/"  

