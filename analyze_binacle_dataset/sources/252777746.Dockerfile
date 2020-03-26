FROM alpine:latest  
  
COPY run.sh .  
  
RUN apk --no-cache -u add curl groff less python py-pip jq && \  
pip install awscli && \  
apk --purge del py-pip && \  
chmod +x run.sh  
  
CMD ["sh", "run.sh"]  

