FROM alpine:3.7  
ARG VERSION  
ENV VERSION patch  
  
ARG DRY-RUN  
ENV DRY-RUN false  
  
RUN flag=""  
  
RUN if [ ${DRY-RUN} == "true" ] ; then flag="--dry-run --verbose" ; fi  
  
RUN apk add --update \  
python \  
py-pip \  
git \  
&& pip install bumpversion --upgrade -t /usr/local/bin  
  
COPY . /srv  
WORKDIR /srv  
ENTRYPOINT [ "/usr/local/bin/bumpversion", ${VERSION}, ${flag} ]

