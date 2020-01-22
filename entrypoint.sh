#!/bin/bash

set -e

: ${OPENERP_SERVER:='/opt/config/odoo-server.conf'}
# Variables del conf:

: ${LOG_HANDLER:="[':INFO']"}
: ${LOG_LEVEL:='info'}
: ${LOG_DB:="False"}
: ${DATA_DIR:="/var/lib/odoo"}
: ${LOGROTATE:="True"}
: ${CSV_INTERNAL_SEP:=";"}
: ${ADMIN_PASSWD:="admin"}
: ${DB_PORT:="5432"}
: ${DB_USER:="odoo"}
: ${DB_PASSWORD:="odoo"}
: ${DB_TEMPLATE:="template1"}
: ${DB_NAME:="False"}
: ${DB_MAXCONN:="64"}
: ${DB_MAXCONN:="64"}
: ${DEBUG_MODE:="False"}
: ${EMAIL_FROM:="False"}
: ${LIMIT_MEMORY_HARD:="2684354560"}
: ${LIMIT_MEMORY_SOFT:="2147483648"}
: ${LIMIT_REQUEST:="8192"}
: ${LIMIT_TIME_CPU:="300"}
: ${LIMIT_TIME_REAL:="600"}
: ${LIST_DB:="True"}
: ${LONGPOLLING_PORT:="8072"}
: ${MAX_CRON_THREADS:="2"}
: ${OSV_MEMORY_AGE_LIMIT:="1"}
: ${OSV_MEMORY_COUNT_LIMIT:="False"}
: ${PIDFILE:="None"}
: ${PROXY_MODE:="False"}
: ${REPORTGZ:="False"}
: ${SECURE_CERT_FILE:="server.cert"}
: ${SECURE_pkey_FILE:="server.pkey"}
: ${SERVER_WIDE_MODULES:="None"}
: ${SMTP_PASSWORD:="False"}
: ${SMTP_PORT:="25"}
: ${SMTP_SERVER:="localhost"}
: ${SMTP_SSL:="False"}
: ${SMTP_USER:="False"}
: ${SYSLOG:="False"}
: ${TEST_COMMIT:="False"}
: ${TEST_ENABLE:="False"}
: ${TEST_FILE:="False"}
: ${TEST_REPORT_DIRECTORY:="False"}
: ${TIMEZONE:="False"}
: ${TRANSLATE_MODULES:="['all']"}
: ${UNACCENT:="True"}
: ${WITHOUT_DEMO:="True"}
: ${WORKERS:="0"}
: ${XMLRPC:="True"}
: ${XMLRPC_PORT:="8069"}
: ${XMLRPCS:="True"}
: ${XMLRPCS_PORT:="8071"}
: ${DB_HOST:="db"}
: ${DB_FILTER:="^%d"}
# Estas no las estabamos metiendo:
 ## echo 'logfile = '${LOGFILE:-"/var/log/odoo/odoo-server.log"} >> /opt/config/odoo-server.conf; \
 ## echo 'pg_path = '${PG_PATH:-None} >> /opt/config/odoo-server.conf; \

function write_conf() {
	param="$1"
	value="$2"
	if ! grep -q -E "^\s*\b${param}\b\s*=" "$OPENERP_SERVER" ; then
		echo "${param} = ${value}" >> $OPENERP_SERVER
	fi;
}

echo "ENTRYPOINT: Setting conf values"
write_conf "log_handler" $LOG_HANDLER
write_conf "log_level" $LOG_LEVEL
write_conf  "log_db" ${LOG_DB}
write_conf 'data_dir' ${DATA_DIR}
write_conf 'logrotate' ${LOGROTATE}
write_conf 'csv_internal_sep' ${CSV_INTERNAL_SEP}
write_conf 'admin_passwd' ${ADMIN_PASSWD}
write_conf 'db_port' ${DB_PORT}
write_conf 'db_user' ${DB_USER}
write_conf 'db_password' ${DB_PASSWORD}
write_conf 'db_template' ${DB_TEMPLATE}
write_conf 'db_name' ${DB_NAME}
write_conf 'db_maxconn' ${DB_MAXCONN}
write_conf 'db_maxconn' ${DB_MAXCONN}
write_conf 'debug_mode' ${DEBUG_MODE}
write_conf 'email_from' ${EMAIL_FROM}
write_conf 'limit_memory_hard' ${LIMIT_MEMORY_HARD}
write_conf 'limit_memory_soft' ${LIMIT_MEMORY_SOFT}
write_conf 'limit_request' ${LIMIT_REQUEST}
write_conf 'limit_time_cpu' ${LIMIT_TIME_CPU}
write_conf 'limit_time_real' ${LIMIT_TIME_REAL}
write_conf 'list_db' ${LIST_DB}
write_conf 'longpolling_port' ${LONGPOLLING_PORT}
write_conf 'max_cron_threads' ${MAX_CRON_THREADS}
write_conf 'osv_memory_age_limit' ${OSV_MEMORY_AGE_LIMIT}
write_conf 'osv_memory_count_limit' ${OSV_MEMORY_COUNT_LIMIT}
write_conf 'pidfile' ${PIDFILE}
write_conf 'proxy_mode' ${PROXY_MODE}
write_conf 'reportgz' ${REPORTGZ}
write_conf 'secure_cert_file' ${SECURE_CERT_FILE}
write_conf 'secure_pkey_file' ${SECURE_pkey_FILE}
write_conf 'server_wide_modules' ${SERVER_WIDE_MODULES}
write_conf 'smtp_password' ${SMTP_PASSWORD}
write_conf 'smtp_port' ${SMTP_PORT}
write_conf 'smtp_server' ${SMTP_SERVER}
write_conf 'smtp_ssl' ${SMTP_SSL}
write_conf 'smtp_user' ${SMTP_USER}
write_conf 'syslog' ${SYSLOG}
write_conf 'test_commit' ${TEST_COMMIT}
write_conf 'test_enable' ${TEST_ENABLE}
write_conf 'test_file' ${TEST_FILE}
write_conf 'test_report_directory' ${TEST_REPORT_DIRECTORY}
write_conf 'timezone' ${TIMEZONE}
write_conf 'translate_modules' ${TRANSLATE_MODULES}
write_conf 'unaccent' ${UNACCENT}
write_conf 'without_demo' ${WITHOUT_DEMO}
write_conf 'workers' ${WORKERS}
write_conf 'xmlrpc' ${XMLRPC}
write_conf 'xmlrpc_port' ${XMLRPC_PORT}
write_conf 'xmlrpcs' ${XMLRPCS}
write_conf 'xmlrpcs_port' ${XMLRPCS_PORT}
write_conf 'db_host' ${DB_HOST}
write_conf 'dbfilter' "${DB_FILTER}"

case "$1" in
	-- | /opt/odoo/odoo-bin)
		shift
		if [[ "$1" == "scaffold" ]] ; then
			exec /opt/odoo/odoo-bin --config $OPENERP_SERVER "$@"
		else
			exec /opt/odoo/odoo-bin --config $OPENERP_SERVER "$@" "${DB_ARGS[@]}"
		fi
		;;
	-*)
		exec /opt/odoo/odoo-bin --config $OPENERP_SERVER "$@" "${DB_ARGS[@]}"
		;;
	*)
		exec "$@"
esac

exit 1

