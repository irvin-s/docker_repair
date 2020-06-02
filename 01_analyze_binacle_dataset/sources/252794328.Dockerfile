FROM library/python:slim  
MAINTAINER Bastian Widmer <b.widmer@dasrecht.net>  
WORKDIR /data  
RUN pip install --upgrade youtube_dl  
ENTRYPOINT [ "/usr/local/bin/youtube-dl" ]  

