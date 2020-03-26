FROM azul/zulu-openjdk:8

WORKDIR /app
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-cp","/app","org.springframework.boot.loader.JarLauncher"]

# dependencies
ADD app/BOOT-INF/lib /app/BOOT-INF/lib
# spring boot loader
ADD app/org /app/org
# meta-inf
ADD app/META-INF /app/META-INF
# our application
ADD app/BOOT-INF/classes /app/BOOT-INF/classes
