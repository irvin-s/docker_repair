FROM scratch
MAINTAINER Frank Rosquin <frank.rosquin@gmail.com>

COPY .placeholder /etc/stacker/.placeholder
COPY .placeholder /etc/stacker/conf.d/.placeholder
COPY stacker /

ENTRYPOINT ["/stacker"]
CMD ["-config_file=/etc/stacker/stacker.toml"]
