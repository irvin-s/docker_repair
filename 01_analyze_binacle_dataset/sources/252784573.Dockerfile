FROM python:latest  
MAINTAINER Justin Willis <sirJustin.Willis@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY AUTHORS CHANGELOG.md LICENSE README.md setup.py /opt/libenable.so/  
COPY libenable/ /opt/libenable.so/libenable/  
COPY docs/ /opt/libenable.so/docs/  
COPY tests/ /opt/libenable.so/tests/  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
iceweasel \  
openbox \  
xvfb \  
&& pip3 install /opt/libenable.so \  
&& wget -P /tmp $(\  
curl -s https://api.github.com/repos/mozilla/geckodriver/releases \  
| grep browser_download_url \  
| grep $(\  
if [ $(uname -m) == 'x86_64' ]; then echo linux64; else echo linux32; fi\  
) \  
| head -n 1 \  
| cut -d '"' -f 4\  
) \  
&& tar -xzvf /tmp/geckodriver* -C /usr/bin \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80  
VOLUME ~  
  
ENTRYPOINT ["python3", "/opt/libenable.so/libenable"]  

