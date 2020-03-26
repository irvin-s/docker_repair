FROM python:3.5

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["runserver"]