FROM 32bit/debian:jessie
RUN apt-get update; apt-get install --no-install-recommends -y bzip2 wget ca-certificates fuse libglib2.0-0 netpbm python
ADD . /recipe
VOLUME /out

