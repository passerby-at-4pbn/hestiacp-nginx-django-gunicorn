#=================================#
# Non-default Web Domain Template #
# Based on default.tpl            #
#=================================#

server {
  listen      %ip%:%web_port%;
  server_name %domain_idn% %alias_idn%;
  access_log  /var/log/nginx/domains/%domain%.log combined;
  access_log  /var/log/nginx/domains/%domain%.bytes bytes;
  error_log   /var/log/nginx/domains/%domain%.error.log error;

  include %home%/%user%/conf/web/%domain%/nginx.forcessl.conf*;

  location ~* ^.+\.(jpeg|jpg|png|webp|gif|bmp|ico|svg|css|js)$ {
    expires max;
  }
  location = /favicon.ico {
    access_log    off;
    log_not_found off;
  }
  location / {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass       http://unix:%home%/%user%/web/%domain%/public_html/app/gunicorn.sock;
  }
  location /error/ {
    alias %home%/%user%/web/%domain%/document_errors/;
  }
  location ~ /\.(?!well-known\/) {
    deny   all;
    return 404;
  }
  location /vstats/ {
    alias   %home%/%user%/web/%domain%/stats/;
    include %home%/%user%/web/%domain%/stats/auth.conf*;
  }

  include %home%/%user%/conf/web/%domain%/nginx.conf_*;
}
