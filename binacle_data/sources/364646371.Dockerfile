FROM daocloud.io/python:2.7

COPY requirements.txt /usr/src/
RUN mkdir -p ~/.pip/	\
	&& echo "[global]\nindex-url=https://pypi.mirrors.ustc.edu.cn/simple" >> ~/.pip/pip.conf \
	&& pip install -r /usr/src/requirements.txt