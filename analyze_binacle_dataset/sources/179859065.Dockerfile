FROM gwul/vivo_app:1.8
MAINTAINER Justin Littman <justinlittman@gwu.edu>

ADD gwlocal.n3 /tmp/VIVO-rel/rdf/tbox/filegraph/
ADD linkvoj_ontology_v2.33.ttl /tmp/VIVO-rel/rdf/tbox/filegraph/
RUN mkdir /tmp/VIVO-rel/vitro-core/webapp/rdf/auth/firsttime
ADD users.n3 /tmp/VIVO-rel/vitro-core/webapp/rdf/auth/firsttime/
ADD addl_permission_config.n3 /tmp/VIVO-rel/vitro-core/webapp/rdf/auth/everytime/
ADD addl_PropertyConfig.n3 /tmp/VIVO-rel/rdf/display/everytime/
ADD initialTBoxAnnotations.n3 /tmp/VIVO-rel/rdf/tbox/firsttime/
#ADD menu.n3 /tmp/VIVO-rel/rdf/display/firsttime/
