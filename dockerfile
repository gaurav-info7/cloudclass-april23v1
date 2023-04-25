ARG VERSION=latest

FROM ubuntu:${VERSION}

MAINTAINER gaurav.info7@gmail.com

RUN apt update && apt upgrade -y

RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && apt install tzdata -y && dpkg-reconfigure --frontend noninteractive tzdata && apt-get install nginx -y && apt install vim -y && apt install php-fpm php-mysql php-mbstring php-xml php-zip -y && echo "<?php phpinfo(); ?>" >> /var/www/html/index.php && touch /run/php/php8.1-fpm.sock && sed -i 's/index.html/index.php index.html/g' /etc/nginx/sites-available/default && sed -i 's@server_name _;@server_name _; location ~ \.php$ {include snippets/fastcgi-php.conf; fastcgi_pass unix:/run/php/php8.1-fpm.sock;}@g' /etc/nginx/sites-available/default && echo "service nginx restart" >> /etc/entrypoint.sh && echo "service php8.1-fpm restart" >> /etc/entrypoint.sh && echo "tail -f /dev/null" >> /etc/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
