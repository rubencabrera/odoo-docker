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

## Generate a docker-compose file to run locally

A convenience script named `odoo_docker_cli` is provided to generate a
`docker-compose.yaml` file both for prod and development.

### Installing the `odoo_docker_cli` tool

#### Pre-reqs

It's best to use [pyenv][pyenv-installer] to install this script with the
[pyenv-virtualenv plugin][pyenv-virtualenv].

#### Installation

Once the virtualenv thing is sorted, just jun `pip install .`

### Use the cli tool

You can run `odoo_docker_cli` after installation and follow the prompts to
get a `docker-compose.yaml` file you can then use (with `docker compose up`)
to run this docker image with volumes for the code and data.

### Running with docker-compose

Some environment variables can be set before running to skip some prompts:
`ODOO_DOCKER_PROJECT_NAME`, `ODOO_DOCKER_REPOS_HOST_PATH` and
`ODOO_DOCKER_UPSTREAM_HOST_PATH`

You can add more environment variables to the odoo container section for
odoo specific configuration (see details below).

Run `docker-compose up` after your `docker-compose.yaml` file has been created
and navigate to `localhost:8069` (or your chosen port) to get started. On first
run, database initialization takes a while.

### Developing using this image

With the provided `docker-compose.yml`, all the repos will be in the code
volume, named using the environment variable `$ODOO_DOCKER_PROJECT_NAME`
(with a default value of `odoo_docker`).

The docker compose volume with the code configured in the given
`docker-compose.yml` will need an existing **empty** directory where the repos
will be cloned (if not empty, the content will be mounted as is). The default
path is `${HOME}/.${ODOO_DOCKER_PROJECT_NAME}_repos` and can be overriden by
setting the `$ODOO_DOCKER_REPOS_HOST_PATH` (to an existing empty directory)
before running `docker-compose up`.

The repos are all cloned using git with `--depth=1`, so can be worked as any
other git repo.

#### Debugging

[pudb][pudb] is now included in the base image. To insert a breaking point add
these lines of code to where you'll need to look into:

```python
from pudb.remote import set_trace
set_trace(host='0.0.0.0')
```

The `6899` port will need to be open (see the docker-compose).

Then run the container again, get it to hit the breaking point where the
`set_trace` is and connect with:

```
telnet 127.0.0.1 6899
```

And it will open the terminal debugger. See [upstream docs][pudb] for more
details.


## Odoo server config using environment variables

Odoo uses a config file that is a bit of a pain with a docker 
container. This images allow you to pass those config values in
environment variables. Here's a list of the available ones, you can
find them documented in the official Odoo documentation with the
same name in lower case:

| ENV var | Default value |
| --- | --- |
| `ADMIN_PASSWD` | `admin` |
| `CSV_INTERNAL_SEP` | `;` |
| `DATA_DIR` | `/var/lib/odoo` |
| `DB_HOST` | `db` |
| `DB_FILTER` | `^%d` |
| `DB_MAXCONN` | `64` |
| `DB_NAME` | `False` |
| `DB_PASSWORD` | `odoo` |
| `DB_PORT` | `5432` |
| `DB_USER` | `odoo` |
| `DB_TEMPLATE` | `template1` |
| `DEBUG_MODE` | `False` |
| `EMAIL_FROM` | `False` |
| `GEVENT_PORT` | `8072` |
| `LIMIT_MEMORY_HARD` | `2684354560` |
| `LIMIT_MEMORY_SOFT` | `2147483648` |
| `LIMIT_REQUEST` | `8192` |
| `LIMIT_TIME_CPU` | `60` |
| `LIMIT_TIME_REAL` | `120` |
| `LIST_DB` | `True` |
| `LOG_DB` | `False` |
| `LOG_HANDLER` | `[':INFO']` |
| `LOG_LEVEL` | `info` |
| `LOGROTATE` | `True` |
| `MAX_CRON_THREADS` | `2` |
| `OSV_MEMORY_COUNT_LIMIT` | `False` |
| `PIDFILE` | `None` |
| `PROXY_MODE` | `False` |
| `REPORTGZ` | `False` |
| `SECURE_CERT_FILE` | `server.cert` |
| `SECURE_PKEY_FILE` | `server.pkey` |
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
| `TRANSIENT_AGE_LIMIT` | `1` |
| `TRANSLATE_MODULES` | `['all']` |
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
[pudb]: https://documen.tician.de/pudb/index.html
[pyenv-installer]: https://github.com/pyenv/pyenv#automatic-installer
[pyenv-virtualenv]: https://github.com/pyenv/pyenv-virtualenv#installation
