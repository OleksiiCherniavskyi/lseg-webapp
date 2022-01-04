FROM centos:latest
MAINTAINER "Oleksii Cherniavskyi"
ENV APP=lseg-webapp
RUN yum -y install httpd php net-tools
RUN mkdir /var/www/health && \
    mkdir /var/www/me && \
    mkdir /run/php-fpm
ADD apache_conf.d/ /etc/httpd/conf.d
ADD src/index-health.php /var/www/health/index.php
ADD src/index-me.php /var/www/me/index.php
ADD apache_conf.d/ /etc/httpd/conf.d
ADD run.sh /
ENTRYPOINT ["/run.sh"]
EXPOSE 80
