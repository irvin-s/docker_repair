FROM python:3.6-alpine

# Add curl for automatic reporting
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

# Create the cron job to run every 5 minutes
COPY run_report /bin/runreport
RUN chmod +x /bin/runreport
RUN (crontab -l && echo "*/5 * * * * /bin/runreport > /dev/null 2&>1") | crontab -

# install requirements
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy files to the container
RUN mkdir /dashboard/
COPY . /dashboard/
WORKDIR /dashboard/
EXPOSE 8000

# Sets production config mode
ENV FLASK_CONFIG="production"

# Create the empty database
RUN python manage.py setup

RUN crond -l 4 -L /var/log/cron.log

# Startup the cron service and gunicorn
CMD crond && gunicorn -c gunicorn_conf.py manage:app