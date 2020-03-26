FROM swiftdocker/swift:latest

WORKDIR /code

COPY Package.swift ./
# Using older version, manually patch its little "problem".
RUN swift build || \
  rm Packages/Curassow-0.2.0/example.swift && \
  swift build --configuration release

COPY ./Sources ./Sources/
RUN swift build --configuration release

CMD .build/release/ffmailman --workers 4 --bind 0.0.0.0:8000
