FROM ubuntu:20.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install sudo make
RUN mkdir /root/dotfiles
WORKDIR /root/dotfiles
COPY ./ ./
RUN sudo make setup
RUN sudo chsh -s /bin/zsh
WORKDIR /root
