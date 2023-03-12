# syntax=docker/dockerfile:1

FROM golang:1.18.1-bullseye
RUN apt-get update
RUN apt-get -y install openssh-server

COPY root /root
COPY etc /etc
COPY goimg /goimg

WORKDIR /goimg
RUN go mod download
RUN go build -o goimg
RUN mkdir img
RUN adduser imgbk
RUN chown imgbk:imgbk img
RUN echo "imgbk:aaadir.123" | chpasswd

ENTRYPOINT ["sh","-c", "service ssh start; /goimg/goimg"]