FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y unzip tar curl sed
COPY ./cs2.sh /home/ubuntu
WORKDIR /home/ubuntu
CMD /home/ubuntu/cs2.sh
