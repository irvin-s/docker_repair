FROM python:3.6.8-stretch

LABEL "version"="1.0.0"
LABEL "repository"="https://github.com/jefftriplett/python-actions"
LABEL "homepage"="https://github.com/jefftriplett/python-actions"
LABEL "maintainer"="Jeff Triplett <jeff.triplett@github.com>"

LABEL "com.github.actions.name"="GitHub Action for Python"
LABEL "com.github.actions.description"="Wraps the Python CLI to enable common python/pip commands."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY LICENSE README.md entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--help" ]
