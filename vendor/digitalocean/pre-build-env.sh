#!/bin/bash
# Create a temporary .env file with a placeholder secret key for the build process
# This will be overwritten by the 001_onboot script when the instance boots

mkdir -p /srv/authentik
echo "AUTHENTIK_SECRET_KEY=temporary-build-key-will-be-replaced-on-boot" > /srv/authentik/.env
