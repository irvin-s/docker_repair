FROM nginx
COPY proxy.conf /proxy.conf
COPY startup.sh /startup.sh
CMD /startup.sh
