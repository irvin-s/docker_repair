FROM microsoft/nanoserver

ADD bin/guestbook.exe c:/app/guestbook.exe
ADD src/public c:/app/public

WORKDIR /app

CMD ["c:/app/guestbook.exe"]