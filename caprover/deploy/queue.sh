#!/bin/sh

php artisan queue:work --tries=3 --timeout=90
