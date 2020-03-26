FROM ubuntu:17.10  
  
# Start with a basic python3.6 Ubuntu image  
RUN apt-get update \  
&& apt-get install -y software-properties-common curl \  
&& apt autoremove -y \  
&& apt-get update \  
&& apt-get remove -y software-properties-common \  
&& apt-get install -y python3.6 \  
&& curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \  
&& python3.6 /tmp/get-pip.py  
  
#  
# && apt-get remove -y curl \  
# && apt autoremove -y  
# && rm -rf /var/lib/apt/lists/*  
# install modelbender OS dependencies  
RUN apt-get install -y graphviz  
RUN apt-get install -y python-virtualenv  
# don't do this...  
# replace it with `pip install -r requirements.txt` once everything stabilises  
# so that we have single version of truth for dependencies/dev  
RUN pip install --upgrade pip  
RUN pip install sphinx  
RUN pip install click  
RUN pip install ruamel.yaml  
RUN pip install blockdiag  
RUN pip install seqdiag  
RUN pip install actdiag  
RUN pip install nwdiag  
  
# click is fussy about locales, which is OK by me  
ENV LC_ALL=C.UTF-8  
ENV LANG=C.UTF-8  
  
# install modelbender python dependencies  
COPY . /app  
# Do this when stable, but it's a pain to wait every build when code changes  
# RUN pip install -r /app/requirements.txt  
ENTRYPOINT ["python3.6", "/app/scripts/modelbender.py"]  
  

