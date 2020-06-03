FROM python

WORKDIR /data
CMD cd /data && python -m http.server 80

EXPOSE 80
