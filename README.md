<p align="center">
    <img src="https://goauthentik.io/img/icon_top_brand_colour.svg" height="150" alt="authentik logo">
</p>

---

[![Join Discord](https://img.shields.io/discord/809154715984199690?label=Discord&style=for-the-badge)](https://goauthentik.io/discord)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/goauthentik/appliances/build-do.yml?branch=main&style=for-the-badge)](https://github.com/goauthentik/appliances/actions/workflows/build-do.yml)
![Latest version](https://img.shields.io/docker/v/beryju/authentik?sort=semver&style=for-the-badge)
[![](https://img.shields.io/badge/Help%20translate-transifex-blue?style=for-the-badge)](https://www.transifex.com/beryjuorg/authentik/)

# authentik Appliances

This repository contains the infrastructure code to build authentik appliance images for various cloud providers. Currently supported:

- DigitalOcean Droplet Images

## Project Overview

The authentik appliances project uses HashiCorp Packer and Ansible to create pre-configured virtual machine images with authentik pre-installed and ready to use. These images simplify the deployment process for users who want to run authentik on cloud platforms.

## Architecture

The project consists of the following components:

- **Packer Configuration**: `digitalocean.pkr.hcl` defines the build process for DigitalOcean droplet images.
- **Ansible Roles**: The `goauthentik.appliance` role configures the system and installs authentik.
- **CI/CD Pipeline**: GitHub Actions workflow in `.github/workflows/build-do.yml` automates the build process.

## Build Process

The build process follows these steps:

1. Packer creates a new virtual machine instance on the target platform (e.g., DigitalOcean)
2. Ansible provisions the instance with Docker and other dependencies
3. The authentik application is installed via Docker Compose
4. System configurations are applied (firewall, MOTD, etc.)
5. The instance is converted to an image/snapshot

## Environment Variables

The following environment variables are used during the build process:

- `AUTHENTIK_VERSION`: The version of authentik to install
- `DIGITALOCEAN_TOKEN`: API token for DigitalOcean (required for building DO images)

## Development Setup

### Prerequisites

- Python 3.12
- uv (Python package manager)
- HashiCorp Packer

### Getting Started

1. Clone this repository
2. Install dependencies:
   ```
   uv venv
   uv sync
   ```
3. Install Ansible roles:
   ```
   uv run ansible-galaxy install -p ./roles -r requirements.yml
   ```
4. Initialize Packer:
   ```
   packer init .
   ```

### Building Images Locally

To build a DigitalOcean image:

```bash
packer build -var "authentik_version=2025.8.0" digitalocean.pkr.hcl
```

## Notes

- The authentik secret key is generated at boot time in the 001_onboot script using pwgen