FROM django:onbuild
RUN mv /usr/src/app/djangoctf/settings.json.example /usr/src/app/djangoctf/settings.json
RUN cd /usr/src/app && python manage.py collectstatic --noinput && python manage.py makemigrations ctfapp --noinput && python manage.py migrate --noinput
