FROM php:apache

# this signal should make apache do a graceful stop
STOPSIGNAL SIGWINCH

COPY index.php /var/www/html/

HEALTHCHECK --interval=2s CMD curl -f http://localhost
