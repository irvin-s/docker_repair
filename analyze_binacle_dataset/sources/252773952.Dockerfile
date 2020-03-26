FROM frolvlad/alpine-python3  
  
RUN apk add --no-cache libstdc++ lapack-dev && \  
apk add --no-cache \  
\--virtual=.build-dependencies \  
g++ gfortran musl-dev \  
python3-dev && \  
ln -s locale.h /usr/include/xlocale.h && \  
pip install numpy && \  
pip install pandas && \  
# pip install scipy && \  
# pip install scikit-learn && \  
find /usr/lib/python3.*/ -name 'tests' -exec rm -r '{}' \+ && \  
rm /usr/include/xlocale.h && \  
rm -r /root/.cache && \  
apk del .build-dependencies  
  
# ENTRYPOINT [ "/usr/bin/tini", "--" ]  
# CMD [ "/bin/bash" ]  
# RUN conda install pandas  
# RUN python -m pip install pandas  
RUN mkdir -p /usr/src/app  
  
## Requirements  
COPY . /usr/src/app/  
# COPY requirements.txt /usr/src/app/  
WORKDIR /usr/src/app  
  
# COPY requirements.txt /usr/src/app/  
RUN pip install -r requirements.txt  
  
EXPOSE 8001  
CMD python3 /usr/src/app/app_main.py  

