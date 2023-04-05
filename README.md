# hestiacp-nginx-django-gunicorn
Work in progress.
Django custom templates for Hestia Control Panel with nginx+php-fpm. Per-domain gunicorn systemd service in addition )

#### root

      # apt update
      # apt install -y libmysqlclient-dev python3-pip python3-dev python3-virtualenv

#### user
create folder structure for an application and install required pip packages into virtualenv

      $ cd ~/web/app.example.com/public_html
      $ mkdir app
      $ git clone ... app
      $ virtualenv .env
      $ source .env/bin/activate
      (.env)...$ pip install django gunicorn mysqlclient
      (.env)...$ deactivate
      $ chown -R example_user:example_user .env/

#### root
copy template files into /usr/local/hestia/data/templates/web/nginx/php-fpm/


#### PS
manual start reminder

      $ cd ~/web/app.example.com/public_html
      $ gunicorn --bind unix:app/gunicorn.sock app.wsgi:application
