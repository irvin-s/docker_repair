FROM m0sth8/base  
  
RUN apt-get update \  
&& /build/enable_repos.sh \  
&& /build/nodejs.sh \  
&& /build/finalize.sh

