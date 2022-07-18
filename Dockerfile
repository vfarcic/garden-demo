FROM golang:1.18 AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN go build -v -o silly-demo

FROM alpine:3.16.0
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
EXPOSE 8080
ENV VERSION 1.0.6
CMD ["silly-demo"]
COPY --from=build /src/silly-demo /usr/local/bin/silly-demo
RUN chmod +x /usr/local/bin/silly-demo
