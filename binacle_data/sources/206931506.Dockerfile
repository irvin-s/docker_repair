FROM python:<%= reqMajor %>.<%= reqMinor %>-onbuild
EXPOSE 8000
CMD ["python<%= reqMajor %>", "./run.py"]
