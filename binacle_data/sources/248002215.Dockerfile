FROM postgres:9.4

COPY st_geometry.so /usr/lib/postgresql/9.4/lib/st_geometry.so

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/9.4/lib

CMD ["postgres"]
