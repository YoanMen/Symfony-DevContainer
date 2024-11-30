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
Change folder name by your App name, in `.devcontainer/.env` change `APP_NAME` by your project name.
On VSCode open your project and select 'Reopen in Container'.

Initialize your Symfony project with :
```bash
  make new-project
```
You can see all commands with : 
```bash
  make help
```

### Add on Symfony project

Clone repository and copy all files into your own Symfony project except `.git` folder.
```bash
  git clone https://github.com/YoanMen/Symfony-DevContainer.git 
```
In `.devcontainer/.env` change `APP_NAME` by your project name .
On VSCode select 'Reopen in Container'.

You can see all commands with : 
```bash
  make help
```
## License

MIT License.
