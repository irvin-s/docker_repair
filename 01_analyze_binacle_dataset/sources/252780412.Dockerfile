FROM python:2.7.13-alpine  
  
WORKDIR /lan-party-manager  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
ENV FLASK_APP=/lan-party-manager/app/__init__.py  
ENV FLASK_DEBUG=0  
ENV OAUTHLIB_INSECURE_TRANSPORT=0  
ENV OAUTHLIB_RELAX_TOKEN_SCOPE=0  
ENTRYPOINT ["flask"]  
  
EXPOSE 5000  
WORKDIR /lan-party-manager/app  
  
CMD ["run", "--host=0.0.0.0"]  

