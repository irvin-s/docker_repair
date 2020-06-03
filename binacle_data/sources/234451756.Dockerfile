FROM alpine:3.4

RUN apk --update --no-cache add \
		bash \
		py-pip \
		postgresql-dev  \
		postgresql \
		python-dev \
		musl-dev \
		gcc \
		git

ADD https://raw.githubusercontent.com/CanalTP/kirin/master/requirements.txt .
RUN pip install --upgrade pip 
RUN pip install	-r requirements.txt

CMD while ! pg_isready -h kirin_database -d kirin -U navitia; do sleep 5; done; python manage.py db upgrade
