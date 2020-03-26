FROM python:onbuild  
ENV PORT 8080  
EXPOSE 8080  
RUN pip install .  
ENTRYPOINT ["wioleet"]  
CMD ["serve"]  

