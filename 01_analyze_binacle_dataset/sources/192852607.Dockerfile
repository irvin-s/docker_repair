FROM django:python2

RUN mkdir -p /usr/src/{app,config,runtime}
WORKDIR /usr/src/app

COPY API/requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY docker/config/common.json /usr/src/config/
COPY API/ /usr/src/app/

COPY docker/api/create-default-channels.py /usr/src/runtime/
COPY docker/api/run.sh /usr/src/runtime/

EXPOSE 8000
CMD ["/usr/src/runtime/run.sh"]
