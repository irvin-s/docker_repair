FROM perl:5.20

# install dependencies for perl script
RUN cpanm install DBI
RUN cpanm install DBD::mysql

# copy scripts for 
COPY start_gmond.sh .
COPY xtremweb.gmond.pl .

EXPOSE 8649

RUN chmod +x start_gmond.sh
ENTRYPOINT [ "./start_gmond.sh" ]

