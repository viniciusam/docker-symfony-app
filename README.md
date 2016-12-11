Image that I'm using to deploy my symfony app.

### Volumes
/var/www/html

### ENV
Name          | Default Value
--------------|--------------
SYMFONY_ENV   | prod 
DATABASE_HOST | 127.0.0.1
DATABASE_PORT | 3306
DATABASE_NAME | symfony
DATABASE_USER | symfony

### Notes
If you delete .keepvendor and restarts the instance, the vendor folder will be deleted and compose install fired again.
If you delete .keepcache and restart the instance, the cache will be reset. This is useful when changing ENV vars.
