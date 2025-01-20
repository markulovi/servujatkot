FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y unzip tar curl sed
COPY cs2.sh
CMD cs2.sh
