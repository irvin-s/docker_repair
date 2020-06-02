FROM hashicorp/terraform:light  
  
# Install python3  
RUN apk add --no-cache python3 bash jq && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \  
rm -r /root/.cache  
  
# Install requirements  
COPY requirements.txt .  
RUN pip3 install -r requirements.txt  
  
# Install terraform-nanny  
COPY terraform-nanny.py /usr/bin/terraform-nanny  
RUN chmod +x /usr/bin/terraform-nanny  
  
WORKDIR "/src"  
  
ENTRYPOINT ["terraform-nanny"]  

