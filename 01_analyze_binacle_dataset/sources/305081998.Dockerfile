FROM django:1.9.6

WORKDIR /usr/src/app

COPY ./gfklookupwidget /usr/src/app/gfklookupwidget

RUN django-admin.py startproject mysite . && \
    ./manage.py migrate && \
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | python manage.py shell && \
    ./manage.py startapp example && \
    sed -i 's/INSTALLED_APPS = \[/INSTALLED_APPS = \["gfklookupwidget", "example",/' ./mysite/settings.py && \
    echo "from django.db import models\n\
from django.contrib.contenttypes.fields import GenericForeignKey\n\
from django.contrib.contenttypes.models import ContentType\n\
import gfklookupwidget.fields\n\
\n\
class TaggedItem(models.Model):\n\
    tag = models.SlugField()\n\
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)\n\
    object_id = gfklookupwidget.fields.GfkLookupField('content_type')\n\
    content_object = GenericForeignKey('content_type', 'object_id')\n\
\
    def __str__(self):\n\
        return self.tag" > example/models.py && \
    echo "from django.contrib import admin\n\
import example.models\n\
admin.site.register(example.models.TaggedItem)" > example/admin.py && \
    ./manage.py makemigrations && \
    ./manage.py migrate

CMD ["./manage.py", "runserver", "0.0.0.0:8000"]
