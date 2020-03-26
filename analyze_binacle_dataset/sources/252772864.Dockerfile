FROM python:2.7-onbuild  
CMD ["python", "-u", "cleaner.py"]  
#ENTRYPOINT ["/usr/src/app/cleaner.py"]

