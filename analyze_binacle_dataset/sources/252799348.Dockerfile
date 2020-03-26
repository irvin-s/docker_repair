FROM alpine  
  
ENV moinmoin_link="http://static.moinmo.in/files/moin-1.9.8.tar.gz"  
ENV package_name="moinmoin.tar.gz"  
ENV export_dir="/data/moinmoin"  
RUN apk update \  
&& apk upgrade \  
&& apk add python zlib py-docutils libxapian xapian-bindings-python \  
uwsgi uwsgi-python \  
&& wget -O $package_name $moinmoin_link \  
&& mkdir -p /data/moinmoin \  
&& tar -xzf $package_name -C $export_dir \  
&& find $export_dir -mindepth 2 -maxdepth 2 -print0 | \  
xargs -0 -I {} mv {} $export_dir/ \  
&& find $export_dir/ -type d \  
-name "moin-*" -print0 | xargs -0 rmdir \  
&& rm $package_name \  
&& cd $export_dir \  
&& python setup.py install --force --prefix=/usr/local \  
&& cd \- \  
&& adduser -HD uwsgi \  
&& mkdir -p /var/run/moin/ \  
&& chown uwsgi:uwsgi /var/run/moin \  
&& mkdir -p /var/log/uwsgi/ \  
&& chown uwsgi:uwsgi /var/log/uwsgi/ \  
&& chown -R uwsgi:uwsgi /usr/local/share/moin  
  
# moin moin configuration  
COPY moin.wsgi /usr/local/share/moin/server/  
COPY wikiconfig.py /usr/local/share/moin/config/  
COPY uwsgi.ini /usr/local/share/moin/  
  
VOLUME ["/var/log/uwsgi"]  
  
EXPOSE 60001  
CMD uwsgi /usr/local/share/moin/uwsgi.ini  

