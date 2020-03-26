FROM pypy:2-slim  
  
MAINTAINER Hagai Cohen <hagai.co@gmail.com>  
  
RUN export PKGS='build-essential libssl-dev' \  
&& set -x \  
&& apt-get update && apt-get install -y ${PKGS} \--no-install-recommends \  
&& pip install crossbar[all] \  
&& rm -rf /var/lib/apt/lists/* \  
&& apt-get purge -y --auto-remove ${PKGS}  
  
ENV PYTHONUNBUFFERED=1  
COPY crossbar /.crossbar  
  
EXPOSE 1111  
WORKDIR /  
ENTRYPOINT ["crossbar"]  
CMD ["start", "--cbdir", "/.crossbar"]  

