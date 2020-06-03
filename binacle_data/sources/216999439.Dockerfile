FROM codefordc2/ckan:latest
LABEL maintainer=codefordc2

# RUN apt-get install -y curl

WORKDIR /usr/lib/ckan/default
COPY ./ ckanext-open_data_dc/
WORKDIR /usr/lib/ckan/default/ckanext-open_data_dc
RUN python setup.py develop

COPY ./ckan/ckan-entrypoint.sh /ckan-entrypoint.sh
RUN chmod +x /ckan-entrypoint.sh
ENTRYPOINT ["/ckan-entrypoint.sh"]
CMD ["ckan-paster","serve","/etc/ckan/default/ckan.ini"]
