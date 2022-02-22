FROM ubuntu:20.04
RUN apt-get update && apt-get install sudo
WORKDIR /home
COPY ./setup.sh ./
RUN sudo ./setup.sh
