FROM python:2-onbuild

EXPOSE 3001
CMD [ "python", "./gamble_server.py" ]

