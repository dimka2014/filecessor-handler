FROM java:8-jre

RUN apt-get update && apt-get install -y make perl

RUN mkdir -p /var/tmp/exiftool && cd /var/tmp/exiftool && \
    wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.05.tar.gz && \
    gzip -dc Image-ExifTool-10.05.tar.gz | tar -xf - && \
    cd Image-ExifTool-10.05 && perl Makefile.PL && make test && make install && rm -rf /var/tmp/exiftool

RUN usermod -u 1000 daemon

USER daemon

ADD filecessor-handler.jar app.jar

VOLUME ["/media"]

ENTRYPOINT ["java","-jar","/app.jar"]

EXPOSE 8080