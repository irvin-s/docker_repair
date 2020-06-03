FROM grahamdumpleton/mod-wsgi-docker:python-2.7-onbuild  
CMD [ "--mount-point", "/puppetboard", "wsgi.py" ]  

