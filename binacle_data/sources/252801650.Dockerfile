FROM python:2-onbuild  
CMD [ "python", "./mandrill_webhooks/app.py" ]

