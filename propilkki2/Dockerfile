FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y wget nano gnupg
RUN wget -O - http://procyon.ddns.net:8080/propilkki_pub.gpg.key | apt-key add -
RUN echo "deb http://procyon.ddns.net:8080/repos/apt/ubuntu focal main" | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get install pp2host
COPY autohost.ini /etc/pp2host/static/autohost.ini
COPY pp2host.conf /etc/pp2host/pp2host.conf
ARG ORGA
ARG ADMIN
ENV ORGA $ORGA
ENV ADMIN $ADMIN
RUN sed -i "s/\$ORGA/$ORGA/g" /etc/pp2host/pp2host.conf
RUN sed -i "s/\$ADMIN/$ADMIN/g" /etc/pp2host/pp2host.conf
CMD ["sh", "-c", "service pp2host start && tail -f /dev/null"]
