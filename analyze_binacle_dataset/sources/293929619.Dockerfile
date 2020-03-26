FROM redis:3.0-nanoserver

ADD redis-slave.ps1 c:/Redis/redis-slave.ps1

CMD ["powershell", "c:/Redis/redis-slave.ps1"]