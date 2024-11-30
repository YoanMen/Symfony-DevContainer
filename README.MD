# Symfony environment Dev Container

## Needed

- Docker
- VsCode

## About

This is a basic setup for a Symfony development environment using Docker and Visual Studio Code.

## Notes

You may need to adjust it based on your specific needs.

#### services

- MariaDB
- phpmyAdmin
- maildev
- Symfony CLI

#### environment

- Xdebug
- Composer
- Symfony CLI
- NPM and Node

## Installation

### New Symfony project

Clone repository

```bash
  git clone https://github.com/YoanMen/Symfony-DevContainer.git
```

Change folder name by your App name, remove `README.MD`, in `.devcontainer/.env` change `APP_NAME` by your project name.
On VSCode open your project and select 'Reopen in Container'.

Initialize your Symfony project with :

```bash
  make new-project
```

Create database with :

```bash
  php bin/console doctrine:database:create
```

You can see all commands with :

```bash
  make help
```

### Add on Symfony project

Clone repository and copy all files into your own Symfony project except `.git` folder and `README.MD` file.

```bash
  git clone https://github.com/YoanMen/Symfony-DevContainer.git
```

In `.devcontainer/.env` change `APP_NAME` by your project name .
On VSCode select 'Reopen in Container'.

Create database with :

```bash
  php bin/console doctrine:database:create
```

You can see all commands with :

```bash
  make help
```

## Usage

#### PhpMyAdmin

You can connect on phpmyAdmin page per default http://localhost:8102/ with `root` and `rootpassword`.

#### Maildev

Acces on maildev interface per default http://localhost:1080/

#### MariaDB CLI

To connect with CLI use :

```bash
mariadb -h db_server -P 3306 -u root -p
```

Password is `rootpassword`.

## License

MIT License.
