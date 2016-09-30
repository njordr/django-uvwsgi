#!/bin/bash

PATH=/opt/python/bin:$PATH

cd /opt/django_app

pip3 install -r requirements.txt

if [[ ${COLLECT_STATIC} == "yes" ]]; then
    python3 manage.py collectstatic
fi

uwsgi --emperor /etc/uwsgi/sites
