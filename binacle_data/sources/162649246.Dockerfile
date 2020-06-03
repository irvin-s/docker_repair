# This is a comment
FROM gdgomsk/devfest-app-tests-fakeserver:base
MAINTAINER Alex Korovyansky <korovyansk@gmail.com>

COPY lighttpd.conf /etc/lighttpd/
COPY manifest.json                 /var/www/servers/devfest-app.gdgomsk.org/static-files/
COPY test_data_v1.json             /var/www/servers/devfest-app.gdgomsk.org/static-files/
COPY images/android_man.png        /var/www/servers/devfest-app.gdgomsk.org/static-files/images/speaker_thumbnail_url.png
COPY images/android_super.png      /var/www/servers/devfest-app.gdgomsk.org/static-files/images/session_photo_url_keynote.png
COPY images/android_standard.png   /var/www/servers/devfest-app.gdgomsk.org/static-files/images/session_photo_url_standard.png
COPY images/android_youtube.png    /var/www/servers/devfest-app.gdgomsk.org/static-files/images/video_library_thumbnail_url_standard.png

CMD lighttpd -D -f /etc/lighttpd/lighttpd.conf