FROM gwul/vivo_app:1.7
MAINTAINER Justin Littman <justinlittman@gwu.edu>

ADD gwlocal.n3 /tmp/vivo-rel-1.7/rdf/tbox/filegraph/
RUN mkdir /tmp/vivo-rel-1.7/vitro-core/webapp/rdf/auth/firsttime
ADD users.n3 /tmp/vivo-rel-1.7/vitro-core/webapp/rdf/auth/firsttime/
ADD addl_permission_config.n3 /tmp/vivo-rel-1.7/vitro-core/webapp/rdf/auth/everytime/
ADD addl_PropertyConfig.n3 /tmp/vivo-rel-1.7/rdf/display/everytime/
#ADD menu.n3 /tmp/vivo-rel-1.7/rdf/display/firsttime/
