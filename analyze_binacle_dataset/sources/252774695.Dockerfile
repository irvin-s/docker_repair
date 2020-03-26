FROM baselibrary/python:2.7  
MAINTAINER ShawnMa <qsma@thoughtworks.com>  
  
## Packages  
RUN \  
pip install shadowsocks==2.8.2  
  
ENTRYPOINT ["/usr/local/bin/ssserver"]  
  
CMD ["-s", "0.0.0.0", "-p", "8388", "-k", "$SS_PASSWORD", "-m", "aes-256-cfb"]  
  

