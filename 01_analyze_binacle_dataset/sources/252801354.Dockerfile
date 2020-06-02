FROM python:2.7-alpine  
  
WORKDIR /app/user  
ENV PORT 80  
ENV APPLICATION_NAME ""  
# Tell `pymssql` to use bundled FreeTDS  
ENV C_INCLUDE_PATH /usr/include/  
ENV PYMSSQL_BUILD_WITH_BUNDLED_FREETDS 1  
COPY requirements.txt requirements.txt  
  
RUN apk add --no-cache --virtual .build-deps \  
build-base \  
ca-certificates \  
cython \  
freetds-dev \  
freetds \  
libc-dev \  
libffi \  
libffi-dev \  
linux-headers \  
musl-dev \  
openssl-dev \  
openssl \  
pcre-dev \  
python-dev \  
&& pip install -r requirements.txt \  
&& find /usr/local \  
\\( -type d -a -name test -o -name tests \\) \  
-o \\( -type f -a -name '*.pyc' -o -name '*.pyo' \\) \  
-exec rm -rf '{}' \+ \  
&& runDeps="$( \  
scanelf --needed --nobanner --recursive /usr/local \  
| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \  
| sort -u \  
| xargs -r apk info --installed \  
| sort -u \  
)" \  
&& apk add --virtual .rundeps $runDeps \  
&& apk del .build-deps  
  
# Add uWSGI deps  
COPY uwsgi.py /app/user/  
COPY uwsgi.ini /app/user/  
  
EXPOSE $PORT  
  
CMD ["uwsgi", "uwsgi.ini"]  

