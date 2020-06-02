FROM m0sth8/base:latest  
  
  
RUN apt-get update \  
&& /build/python.sh \  
&& /build/python3.sh \  
&& /build/finalize.sh

