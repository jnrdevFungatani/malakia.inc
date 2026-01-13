#!/usr/bin/env bash
set -e

# -------------------------
# WordPress Provision Script
# -------------------------

# Database credentials
DB_NAME=ml_db
DB_USER=wpuser
DB_PASS=secret
DB_HOST=localhost

# WordPress site info
SITE_URL=http://localhost/malakia.inc
SITE_TITLE="CI WordPress"
ADMIN_USER=admin
ADMIN_PASS=admin123
ADMIN_EMAIL=admin@example.com

# Web root
WEB_ROOT=/srv/http/malakia.inc

# Create web root directory if it doesn't exist
mkdir -p $WEB_ROOT
cd $WEB_ROOT

# -------------------------
# Download WordPress core
# -------------------------
wp core download --force --allow-root

# -------------------------
# Create wp-config.php
# -------------------------
wp config create \
  --dbname="$DB_NAME" \
  --dbuser="$DB_USER" \
  --dbpass="$DB_PASS" \
  --dbhost="$DB_HOST" \
  --skip-check

# -------------------------
# Install WordPress
# -------------------------
wp core install \
  --url="$SITE_URL" \
  --title="$SITE_TITLE" \
  --admin_user="$ADMIN_USER" \
  --admin_password="$ADMIN_PASS" \
  --admin_email="$ADMIN_EMAIL"

# -------------------------
# Install Plugins
# -------------------------
wp plugin install wordpress-seo woocommerce --activate

# -------------------------
# Install Theme
# -------------------------
wp theme install twentytwentyfour --activate

# -------------------------
# Finished
# -------------------------
echo "WordPress installation complete at $WEB_ROOT"
echo "Admin user: $ADMIN_USER"
echo "Admin password: $ADMIN_PASS"
echo "Access your site at $SITE_URL"

