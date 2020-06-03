FROM python:2.7  
MAINTAINER Adrian Perez <adrian@adrianperez.org>  
RUN pip install livestreamer  
EXPOSE 8080  
ENTRYPOINT ["livestreamer", \  
"--yes-run-as-root", \  
"--player-external-http", \  
"--player-external-http-port", "8080" \  
]  

