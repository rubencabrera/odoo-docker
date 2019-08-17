# Odoo docker image including other repos.

This repo builds a docker image for Odoo, including [OCA](https://github.com/OCA) repos I find useful. Not all repos are included as
many are specific to local regulations and contradict themselves.

For localisation, I am currently using Spain. If deemed useful, new
branches and tags for images could be created for other countries,
[open an issue](https://github.com/rubencabrera/odoo-docker/issues/new) if you need that, it's an easy win but I haven't 
had to do it. 

# Environment variables

Odoo uses a config file that is a bit of a pain with a docker 
container. This images allows you to pass those config values in
environment variables. Here's a list of the available ones, you can
find them documented in the official Odoo documentation with the
same name in lower case:

|ENV var|Default value|
|`ODOO_DB_USER`|`odoo`|
|`LOG_HANDLER`|`"[':INFO']"`|
|`LOG_LEVEL`|`info`|
|`LOG_DB`|`False`|
|`LOGFILE`|`"/var/log/odoo"`|
|`LOGROTATE`|`True`|
|`CSV_INTERNAL_SEP`|`";"`|
|`ADMIN_PASSWD`|`admin`|
|`DB_HOST`|`localhost`|
|`DB_PORT`|`5432`|
|`DB_USER`|`odoo`|
|`DB_PASSWORD`|`odoo`|
|`DB_TEMPLATE`|`template1`|
|`DB_NAME`|`False`|
|`DB_MAXCONN`|`64`|
|`DBFILTER`|`".*"`|
|`DB_MAXCONN`|`64`|
|`DEBUG_MODE`|`False`|
|`EMAIL_FROM`|`False`|
|`LIMIT_MEMORY_HARD`|`2684354560`|
|`LIMIT_MEMORY_SOFT`|`2147483648`|
|`LIMIT_REQUEST`|`8192`|
|`LIMIT_TIME_CPU`|`60`|
|`LIMIT_TIME_REAL`|`120`|
|`LIST_DB`|`True`|
|`LONGPOLLING_PORT`|`8072`|
|`MAX_CRON_THREADS`|`2`|
|`OSV_MEMORY_AGE_LIMIT`|`1`|
|`OSV_MEMORY_COUNT_LIMIT`|`False`|
|`PG_PATH`|`None`|
|`PIDFILE`|`None`|
|`PROXY_MODE`|`False`|
|`REPORTGZ`|`False`|
|`SECURE_CERT_FILE`|`"server.cert"`|
|`SECURE_pkey_FILE`|`"server.pkey"`|
|`SERVER_WIDE_MODULES`|`None`|
|`SMTP_PASSWORD`|`False`|
|`SMTP_PORT`|`25`|
|`SMTP_SERVER`|`localhost`|
|`SMTP_SSL`|`False`|
|`SMTP_USER`|`False`|
|`SYSLOG`|`False`|
|`TEST_COMMIT`|`False`|
|`TEST_ENABLE`|`False`|
|`TEST_FILE`|`False`|
|`TEST_REPORT_DIRECTORY`|`False`|
|`TIMEZONE`|`False`|
|`TRANSLATE_MODULES`|`"['all']"`|
|`UNACCENT`|`True`|
|`WITHOUT_DEMO`|`True`|
|`WORKERS`|`0`|
|`XMLRPC`|`True`|
|`XMLRPC_PORT`|`8069`|
|`XMLRPCS`|`True`|
|`XMLRPCS_PORT`|`8071`|
