FROM node:slim as frontend
WORKDIR /webapp
COPY package*.json ./
COPY .eslintrc .babelrc .stylelintrc .eslintignore postcss.config.js .browserslistrc ./
COPY frontend/assets frontend/assets
RUN npm install
RUN npm run build

FROM python:3-alpine
ENV PYTHONUNBUFFERED 1
RUN apk update && \
 apk add postgresql-libs && \
 apk add --virtual .build-deps gcc musl-dev postgresql-dev
RUN pip install pipenv
RUN mkdir /code
WORKDIR /code
ADD Pipfile /code/
ADD Pipfile.lock /code/
RUN pipenv install --system --deploy
ADD . /code/
COPY --from=frontend /webapp/frontend/static/dist frontend/static/dist
RUN python manage.py collectstatic
