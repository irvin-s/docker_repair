# Build:
#    sudo docker build -t mixmatch .
# Run the container:
#   sudo docker run -t
#    --volume /<path>/<to>/<local>/mixmatch.conf:/etc/mixmatch/mixmatch.conf:ro
#    --publish 9913:9913 mixmatch

FROM python:3
RUN pip install uwsgi
WORKDIR /usr/app/src/mixmatch
COPY . /usr/app/src/mixmatch
RUN pip install -r /usr/app/src/mixmatch/requirements.txt
RUN pip install /usr/app/src/mixmatch
EXPOSE 9913
CMD /usr/local/bin/uwsgi --ini /usr/app/src/mixmatch/httpd/mixmatch-uwsgi.ini
