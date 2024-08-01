FROM wordpress:6.4.3

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    unzip \
    libpq-dev \
    && docker-php-ext-install -j "$(nproc)" pdo_pgsql pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /var/www/html/wp-content

RUN wget https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress/archive/refs/tags/v3.3.1.zip \
    && unzip v3.3.1.zip \
    && mv postgresql-for-wordpress-3.3.1/pg4wp pg4wp \
    && cp pg4wp/db.php . \
    && rm -rf postgresql-for-wordpress-3.3.1 v3.3.1.zip

COPY wp-config.php /var/www/html/
COPY latch /var/www/html/wp-content/plugins/latch

RUN chown -R www-data:www-data /usr/src/wordpress /var/www/html

WORKDIR /var/www/html
