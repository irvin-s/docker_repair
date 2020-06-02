FROM fedora/python  
  
MAINTAINER Markus Ackermann <ackermann@informatik.uni-leipzig.de>  
  
ENV LANG en_US.UTF-8  
RUN dnf update -y && dnf install -y emacs-nox nmap nmap-ncat net-tools  
  
RUN mkdir -p /dld/logs /dld-wd  
  
WORKDIR /dld-wd/  
  
COPY requirements.txt config.py dld.py tools.py /dld/  
  
COPY baselibs/ /dld/baselibs/  
  
COPY data/ /dld/data/  
  
RUN pip3 install --no-cache-dir -r /dld/requirements.txt  
  
ENTRYPOINT ["python3", "/dld/dld.py"]  
  
CMD ["--help"]  

