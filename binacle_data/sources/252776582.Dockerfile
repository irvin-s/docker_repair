FROM alpine:latest  
  
# 作成者情報  
MAINTAINER toshi <toshi@toshi.click>  
  
ENV LANG C.UTF-8  
RUN apk --update add tzdata \  
bash \  
git && \  
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /aws && \  
apk -Uuv add groff less python py-pip && \  
pip install awscli && \  
apk --purge -v del py-pip && \  
rm /var/cache/apk/*  
  
WORKDIR /aws  
ENTRYPOINT ["aws"]  

