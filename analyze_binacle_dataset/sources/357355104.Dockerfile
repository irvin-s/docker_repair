FROM nginx:1.9

COPY boot.sh /usr/local/bin/boot.sh
COPY config /etc/nginx/

CMD ["sh", "/usr/local/bin/boot.sh"]
