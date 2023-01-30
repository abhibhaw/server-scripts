# React App simple NGINX config 

- Prerequisite NGINX must be installed (scripts available in `OS folder` to install nginx) and react build should be ready to use.
- Must run `sudo nginx -t` to test the config file before restarting the server.
- If all looks great restart the NGINX and enjoy 🚀

## Ways:

1. Just replace the data inside `location` block if you have already configured other details (like ssl)

```
server {
        listen 80;
        listen [::]:80;
        root /var/www/html; # replace this path with react build
        index index.html index.htm index.nginx-debian.html;

        server_name domain.com www.domain.com; # replace with your domain

        location / {
                try_files $uri /index.html;
        }
}
```

2. If you're using pm2 or serving react app at some port.


```
server {
        listen 80;
        listen [::]:80;
        root /var/www/html; # replace this path with react build
        index index.html index.htm index.nginx-debian.html;

        server_name domain.com www.domain.com; # replace with your domain

        location / {
                proxy_pass "http://localhost:3000/"; # replace 3000 with your port number
        }
}
```


3. If you're facing redirect to localhost issue.

```
server {
        listen 80;
        listen [::]:80;
        root /var/www/html; # replace this path with react build
        index index.html index.htm index.nginx-debian.html;

        server_name domain.com www.domain.com; # replace with your domain

        location / {
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_pass "http://localhost:3000/"; # replace 3000 with your port number
        }
}
```
