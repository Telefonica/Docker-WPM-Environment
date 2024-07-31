# Usar la imagen oficial de WordPress como base
FROM wordpress:latest

# Instalar git, las extensiones necesarias para PostgreSQL y limpiar la caché
RUN apt-get update && apt-get install -y \
    git \
    libpq-dev \
    && docker-php-ext-install pdo_pgsql pgsql \
    && docker-php-ext-enable pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Habilitar las extensiones de PostgreSQL en los archivos de configuración de PHP
# RUN sed -i 's/;extension=pgsql/extension=pgsql/' /usr/local/etc/php/php.ini-* \
#     && sed -i 's/;extension=pdo_pgsql/extension=pdo_pgsql/' /usr/local/etc/php/php.ini-*

# Clonar el repositorio postgresql-for-wordpress, mover pg4wp y limpiar
WORKDIR /var/www/html/wp-content
RUN git clone https://github.com/kevinoid/postgresql-for-wordpress.git \
    && mv postgresql-for-wordpress/pg4wp pg4wp \
    && cp pg4wp/db.php . \
    && rm -rf postgresql-for-wordpress

# Copiar wp-config.php al directorio correcto
COPY --chown=www-data:www-data wp-config.php /var/www/html/

# Add Latch plugin
ADD latch /var/www/html/wp-content/plugins/latch

# Volver al directorio raíz
WORKDIR /var/www/html