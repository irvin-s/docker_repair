FROM prologic/python-runtime:2.7-onbuild  
ENTRYPOINT ["irclogger"]  
CMD ["-c", "#circuits", "irc.freenode.net", "6667"]  

