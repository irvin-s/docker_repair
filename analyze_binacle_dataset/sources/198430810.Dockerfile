FROM jpetazzo/squid-in-a-can
COPY deploy_squid.py /tmp/deploy_squid.py
COPY steam.conf /etc/squid3/conf.d/steam.conf
COPY steam_store_id /etc/squid3/steam_store_id
RUN echo "include /etc/squid3/conf.d/*.conf" >> /etc/squid3/squid.conf
EXPOSE 3128
