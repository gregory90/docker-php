FROM gregory90/nginx:latest

RUN echo 'deb http://packages.dotdeb.org wheezy-php55 all' | tee /etc/apt/sources.list.d/php55.list && \
    apt-get update && \
    apt-get install -y php5-cli php5-curl php5-fpm php5-gd php5-mcrypt php5-mysql php5-sqlite php5-intl php5-redis supervisor && \
    mkdir -p /code && \
    mkdir -p /data/logs && \
    rm -rf /etc/php5/fpm/pool.d

ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD pool.d /etc/php5/fpm/pool.d
ADD default /etc/nginx/sites-available/default
ADD php.ini /etc/php5/fpm/php.ini
ADD startFPMWithDockerEnvs.php /opt/startFPMWithDockerEnvs.php
RUN chmod +x /opt/startFPMWithDockerEnvs.php
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD index.php /code/index.php

CMD ["supervisord"]

