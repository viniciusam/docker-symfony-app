#!/bin/bash

sed -i "s/database_host\s*:.*/database_host: $DATABASE_HOST/g" app/config/parameters.yml;
sed -i "s/database_port\s*:.*/database_port: $DATABASE_PORT/g" app/config/parameters.yml;
sed -i "s/database_name\s*:.*/database_name: $DATABASE_NAME/g" app/config/parameters.yml;
sed -i "s/database_user\s*:.*/database_user: $DATABASE_USER/g" app/config/parameters.yml;
sed -i "s|database_password\s*:.*|database_password: $DATABASE_PASSWORD|g" app/config/parameters.yml;

if [ ! -f .keepvendor ]; then
    rm -rf app/vendor/*
    rm -rf html/bundles/*
    composer install --no-dev --optimize-autoloader
    php app/console assetic:dump --env=prod --no-debug
    touch .keepvendor
fi

if [ ! -f .keepcache ]; then
    php app/console cache:clear --env=prod --no-debug
    touch .keepcache
fi

chmod 755 -R .
chmod -f 777 -R app/cache | true
chmod -f 777 -R app/logs  | true

apache2-foreground
