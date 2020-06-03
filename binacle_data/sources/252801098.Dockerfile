FROM python:3-alpine  
LABEL maintainer="Aleksei Zhukov <drdaeman@drdaeman.pp.ru>"  
  
RUN addgroup -S flake8 \  
&& adduser -S -D -h /home/flake8 -g flake8 -s /sbin/nologin flake8 \  
&& mkdir -p /home/flake8/.config \  
&& mkdir /project \  
&& chown flake8:flake8 /project \  
&& pip install --no-cache-dir \  
flake8 \  
flake8-blind-except \  
flake8-builtins \  
flake8-colors \  
flake8-comprehensions \  
flake8-docstrings \  
flake8-import-order \  
flake8-mutable \  
flake8-pep3101 \  
flake8-pyi \  
flake8-quotes \  
flake8-string-format \  
pep8-naming  
  
USER flake8  
COPY flake8.ini /home/flake8/.config/flake8  
WORKDIR /project  
ENTRYPOINT ["flake8"]  

