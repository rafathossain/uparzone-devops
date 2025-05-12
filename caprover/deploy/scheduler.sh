#!/bin/sh

# Write out cron job
echo "* * * * * cd /var/www && php artisan schedule:run >> /var/log/cron.log 2>&1" > /etc/cron.d/laravel-scheduler

# Give execution rights on the cron job
chmod 0644 /etc/cron.d/laravel-scheduler

# Apply cron job
crontab /etc/cron.d/laravel-scheduler

# Start cron
cron -f
