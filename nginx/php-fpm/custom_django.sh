#!/bin/bash
user_name="$1"
domain_name="$2"
home_dir_path="$4"

service_name=gunicorn-`echo $domain_name | sed -e 's/\./-/g'`.service
service_file_path=/etc/systemd/system/$service_name

cat <<EOF > $service_file_path
[Unit]
Description=Gunicorn daemon for $domain_name
After=network.target
[Service]
User=$user_name
Group=www-data
WorkingDirectory=$home_dir_path/$user_name/web/$domain_name/public_html
ExecStart=$home_dir_path/$user_name/web/$domain_name/public_html/.env/bin/gunicorn --workers 2 --bind unix:$home_dir_path/$user_name/web/$domain_name/public_html/app/gunicorn.sock app.wsgi:application
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable $service_name
systemctl start $service_name

exit 0
