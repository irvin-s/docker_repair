FROM nikolaik/python-nodejs:python2.7-nodejs8
ENV PYTHONUNBUFFERED 1
RUN pip install pipenv
RUN mkdir /code
WORKDIR /code
COPY package.json ./
COPY Pipfile Pipfile.lock ./
RUN pipenv -v --two --where sync
RUN npm install
COPY . /code/
