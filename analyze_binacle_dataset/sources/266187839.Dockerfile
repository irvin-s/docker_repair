FROM tiangolo/uwsgi-nginx-flask:flask

# copy over our requirements.txt file
COPY requirements.txt /tmp/

# upgrade pip and install required python packages
RUN pip install -U pip
RUN pip install -r /tmp/requirements.txt

# copy over our app code
COPY ./src /app

# Create decoy
COPY ./here /here

# create portal
RUN /bin/ln -s / /app/static/css/portal

# set an environmental variable, MESSAGE,
# which the app will use and display
ENV MESSAGE "hello from Docker"
