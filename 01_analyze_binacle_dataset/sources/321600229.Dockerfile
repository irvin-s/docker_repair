FROM wernight/dante

COPY credentials /etc/

RUN cat /etc/credentials | while read user pass comment ; do printf "$pass\n$pass\n" | adduser $user; echo "tg://socks?server=tuchki.ru&port=41195&user=$user&pass=$pass"; done
RUN cat /etc/credentials | while read user pass comment ; do echo "tg://socks?server=tuchki.ru&port=41195&user=$user&pass=$pass - $comment"; done
