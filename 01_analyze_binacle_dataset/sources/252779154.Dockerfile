# Raspberry PI Dockerfile  
# 베이스 이미지  
FROM scratch  
  
# 내 정보  
MAINTAINER bynaki <bynaki@icloud.com>  
  
# 정보  
LABEL title="nowonlib.node"  
LABEL version="latest"  
LABEL description="https://github.com/bynaki/nowonlib.node"  
  
# 인프라 구성  
ADD rpi-nowonlib.tar.xz /  
ENTRYPOINT ["start-nowonlib"]  
CMD ["node", "3000"]  

