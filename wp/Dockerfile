FROM wordpress:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    libpq-dev \
    && docker-php-ext-install -j "$(nproc)" pdo_pgsql pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /var/www/html/wp-content
RUN git clone --depth 1 https://github.com/kevinoid/postgresql-for-wordpress.git \
    && mv postgresql-for-wordpress/pg4wp pg4wp \
    && cp pg4wp/db.php . \
    && rm -rf postgresql-for-wordpress

COPY wp-config.php /var/www/html/
COPY latch /var/www/html/wp-content/plugins/latch

RUN chown -R www-data:www-data /usr/src/wordpress /var/www/html

WORKDIR /var/www/html