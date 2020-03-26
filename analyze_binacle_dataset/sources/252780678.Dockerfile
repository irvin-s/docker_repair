FROM mongo  
  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y curl tar \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD assets /assets  
CMD ["/assets/entrypoint.sh"]  

