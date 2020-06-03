FROM devolio/base:latest
RUN mkdir /devolio
WORKDIR /devolio
ADD . /devolio/
RUN pip install -r requirements.txt
CMD python manage.py migrate && make serve

