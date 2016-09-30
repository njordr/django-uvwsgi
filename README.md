# django-uwsgi
Docker container for django with uwsgi

Copy uwsgi\_example.ini, modify it and mount with -v to enable your project:
docker run -d -v /vagrant/python/djangocms01:/opt/django\_app njordr/django-uwsgi

it will run pip -r requirements.txt, so be sure that:

- /opt/django\_app is the base directory of your django project
- DJANGO IS IN YOUR requirements.txt file

If you need to collect static, run this:
docker run -d -v /vagrant/python/djangocms01:/opt/django\_app -e "COLLECT\_STATIC=yes" njordr/django-uwsgi
