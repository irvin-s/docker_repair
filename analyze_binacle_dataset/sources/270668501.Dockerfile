FROM python:3.5-slim
# MAINTAINER Nick Janetakis <nick.janetakis@gmail.com>

ENV INSTALL_PATH /CourseScheduling
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

#CMD git clone git@github.com:flask-admin/flask-admin.git $INSTALL_PATH
#RUN cd $INSTALL_PATH/flask-admin
#RUN python $INSTALL_PATH/flask-admin/setup.py install


COPY . .
RUN pip install --editable .

CMD gunicorn -b 0.0.0.0:8000 --access-logfile - "CourseScheduling.app:create_app()"
