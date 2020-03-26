FROM zewo/swiftdocker:0.5.0

ENV APP_NAME=hello

WORKDIR /$APP_NAME/

ADD ./Package.swift /$APP_NAME/
ADD ./Sources /$APP_NAME/Sources
ADD ./Templates /$APP_NAME/Templates
ADD ./Packages /$APP_NAME/Packages

RUN apt-get update && apt-get install -y libpq-dev
RUN swift build --configuration release -Xcc -I/usr/include/postgresql

EXPOSE 80

ENV LD_LIBRARY_PATH .build/release:$LD_LIBRARY_PATH
CMD .build/release/$APP_NAME
