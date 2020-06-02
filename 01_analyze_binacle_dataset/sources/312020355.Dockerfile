FROM  codevapor/swift:4.1
MAINTAINER Shaun Hubbard <shaunhubbard2013@icloud.com>

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN swift build -c release
EXPOSE 8080
CMD .build/release/Run serve --hostname "0.0.0.0"
