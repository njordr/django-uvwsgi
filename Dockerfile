FROM ubuntu:16.04

MAINTAINER "Giovanni Colapinto" alfheim@syshell.net

RUN apt-get update && apt-get install -y \
    build-essential \
    mysql-client libmysqlclient-dev \
    postgresql-client libpq-dev \
    sqlite3 \
    libxml2-dev \
    libssl-dev \
    libxslt1-dev \
    --no-install-recommends && rm -r /var/lib/apt/lists/*

COPY src/python.tar.gz /tmp/python.tar.gz

RUN mkdir /tmp/python && tar xfz /tmp/python.tar.gz -C /tmp/python --strip-components=1

WORKDIR /tmp/python

RUN ./configure --prefix=/opt/python && make && make install && cd /tmp && rm -Rf python

ENV PATH /opt/python/bin:$PATH

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN pip3 install --upgrade pip && \ 
        pip3 install uwsgi && \
        mkdir /opt/django_app && \
        mkdir -p /etc/uwsgi/sites && \
        chmod 755 /usr/local/bin/entrypoint.sh

COPY uwsgi_example.ini /etc/uwsgi/sites/example.ini

WORKDIR /opt/django_app

CMD ["/usr/local/bin/entrypoint.sh"]
