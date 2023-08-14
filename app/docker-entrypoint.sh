#!/bin/sh

# echo "Waiting for postgres..."

# while ! nc -z postgres-svc 5432; do
#   sleep 0.1
# done

# echo "PostgreSQL started"

# while ! python manage.py flush --no-input 2>&1; do
#   echo "Flusing django manage command"
#   sleep 3
# done
# PGPASSWORD=djangoproject psql --host postgres-svc --port 5432 --username=code.djangoproject --dbname=code.djangoproject < tracdb/trac.sql

echo "Migrate the Database at startup of project"

while ! python manage.py makemigrations  --no-input 2>&1; do
   echo "Migration is in progress status"
   sleep 3
done

# Wait for few minute and run db migraiton
while ! python manage.py migrate  --no-input 2>&1; do
   echo "Migration is in progress status"
   sleep 3
done
python manage.py collectstatic --no-input

echo "Django docker is fully configured successfully."

exec "$@"