# Odoo docker image including other repos.

[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

This repo builds a docker image for Odoo, including [OCA](https://github.com/OCA) repos I find useful. Not all repos are included as
many are specific to local regulations and contradict themselves.

For localisation, I am currently using Spain. If deemed useful, new
branches and tags for images could be created for other countries,
[open an issue][issue-link] if you need that, it's an easy win but I haven't 
had to do it. 

# Usage

## Requirements

You will need Docker and docker compose ([install docs][compose-install]).

This repo includes docker compose files you can use to run Odoo completely
on containers, mounting volumes for persistent data.

Regarding resources, will vary heavily depending on the number of users and
data, but a bare minimum with not much guarantees will be 1GB of RAM. It will
be much better with something above 4GB.

## Running with docker-compose

Run `docker-compose up` in the root path. 

## Environment variables

Odoo uses a config file that is a bit of a pain with a docker 
container. This images allow you to pass those config values in
environment variables. Here's a list of the available ones, you can
find them documented in the official Odoo documentation with the
same name in lower case:

| ENV var | Default value |
| --- | --- |
| `ODOO_DB_USER` | `odoo` |
| `LOG_HANDLER` | `"[':INFO']"` |
| `LOG_LEVEL` | `info` |
| `LOG_DB` | `False` |
| `LOGFILE` | `"/var/log/odoo"` |
| `LOGROTATE` | `True` |
| `CSV_INTERNAL_SEP` | `";"` |
| `ADMIN_PASSWD` | `admin` |
| `DB_HOST` | `localhost` |
| `DB_PORT` | `5432` |
| `DB_USER` | `odoo` |
| `DB_PASSWORD` | `odoo` |
| `DB_TEMPLATE` | `template1` |
| `DB_NAME` | `False` |
| `DB_MAXCONN` | `64` |
| `DB_FILTER` | `"^%d"` |
| `DB_MAXCONN` | `64` |
| `DEBUG_MODE` | `False` |
| `EMAIL_FROM` | `False` |
| `LIMIT_MEMORY_HARD` | `2684354560` |
| `LIMIT_MEMORY_SOFT` | `2147483648` |
| `LIMIT_REQUEST` | `8192` |
| `LIMIT_TIME_CPU` | `60` |
| `LIMIT_TIME_REAL` | `120` |
| `LIST_DB` | `True` |
| `LONGPOLLING_PORT` | `8072` |
| `MAX_CRON_THREADS` | `2` |
| `OSV_MEMORY_AGE_LIMIT` | `1` |
| `OSV_MEMORY_COUNT_LIMIT` | `False` |
| `PG_PATH` | `None` |
| `PIDFILE` | `None` |
| `PROXY_MODE` | `False` |
| `REPORTGZ` | `False` |
| `SECURE_CERT_FILE` | `"server.cert"` |
| `SECURE_pkey_FILE` | `"server.pkey"` |
| `SERVER_WIDE_MODULES` | `None` |
| `SMTP_PASSWORD` | `False` |
| `SMTP_PORT` | `25` |
| `SMTP_SERVER` | `localhost` |
| `SMTP_SSL` | `False` |
| `SMTP_USER` | `False` |
| `SYSLOG` | `False` |
| `TEST_COMMIT` | `False` |
| `TEST_ENABLE` | `False` |
| `TEST_FILE` | `False` |
| `TEST_REPORT_DIRECTORY` | `False` |
| `TIMEZONE` | `False` |
| `TRANSLATE_MODULES` | `"['all']"` |
| `UNACCENT` | `True` |
| `WITHOUT_DEMO` | `True` |
| `WORKERS` | `0` |
|  `XMLRPC`  |  `True`  |
| `XMLRPC_PORT` | `8069` |
| `XMLRPCS` | `True` |
| `XMLRPCS_PORT` | `8071` |


# Getting help

If you need help of have questions, [open an issue][issue-link] or get in
contact. Please bear in mind this is not my current job and this image is
working well enough for my needs, so I haven't alloted time to maintain it,
but I'll do my best to help, especially if it's affecting your product. 


# Ayuda en español

Si necesitas ayuda en español usando esta imagen de Odoo o con algún tema
relacionado, [abre un Issue][issue-link] o ponte en contacto conmigo.

Por favor, ten en cuenta que este no es mi trabajo actualmente y que esta
imagen funciona lo bastante bien como para no requerir mi tiempo, puede que
tarde más de lo que esperas si tu problema es complicado, pero haré lo posible
por ayudar. 

[issue-link]: https://github.com/rubencabrera/odoo-docker/issues/new
[compose-install]: https://docs.docker.com/compose/install/]
