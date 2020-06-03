FROM cr0hn/python3.6-alpine-make:latest as python-base  
COPY requirements.txt .  
RUN pip install -U -r requirements.txt  
  
# Build clean image  
FROM cr0hn/python3.6-alpine-gosu:latest  
COPY \--from=python-base /root/.cache /root/.cache  
COPY \--from=python-base requirements.txt .  
  
RUN pip install -U -r requirements.txt  
  
RUN rm -rf /root/.cache /var/cache/apk/*  
  
COPY woocommerce_subscription_check /app/woocommerce_subscription_check  
COPY deploy/entry_point.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/entry_point.sh  
  
WORKDIR /app  
ENTRYPOINT ["entry_point.sh"]

