#!/bin/bash

PATH=/opt/django-venv/bin:/opt/python/bin:$PATH

cd /opt/django_app

if [[ ${REQUIREMENTS} == "yes" ]]; then
    pip3 install -r requirements.txt
fi

if [[ ${COLLECT_STATIC} == "yes" ]]; then
    python3 manage.py collectstatic --noinput
fi

uwsgi --emperor /etc/uwsgi/sites
