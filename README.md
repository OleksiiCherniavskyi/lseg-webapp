# LSEG Web Application

This repo includes Apache web server (httpd) that is running in docker and respondes to /me and /health URL paths in such a way:
- the route "/me" that will return the local container IP
- the route "/health" that will return "OK {ENV}" if the app is working and the environment
It was implemented by using apache 2.4 mod_alias as well as including PHP module known as php-fpm

Build section

```docker build . -t lseg-webapp:latest```

To run locally on your laptop apply the following:

```docker run -dit --name apache-lseg -p 1234:80 lseg-webapp:latest```

To verify if all routes are working well just check it in your browser by hitting 2 URLs
- http://127.0.0.1:1234/me
- http://127.0.0.1:1234/health 

Note: as alternative way you can use curl instead

- ```curl -L http://127.0.0.1:1234/me```
- ```curl -L http://127.0.0.1:1234/health```
