# DOCKER para odoo 10 de Odoo Community Backports
FROM ubuntu:16.04
MAINTAINER Rubén Cabrera Martínez <rcabrera@praxya.com>
EXPOSE 8069

RUN apt-get update && apt-get install wget git xauth python-pip python-cups python-jinja2 python-unicodecsv python-psycopg2 python-simplejson python-lxml python-imaging python-yaml python-reportlab python-mako python-werkzeug python-dateutil python-unittest2 python-mock python-openid python-docutils python-feedparser python-psutil python-pydot python-vatnumber python-vobject python-xlwt python-ldap python-requests python-decorator python-passlib python-babel python-gevent locales python-webdav python-gdata xfonts-75dpi python-apt xfonts-base python-pyparsing xfonts-utils python-dev python-libxslt1 python-psycopg2 python-geoip python-pybabel python-pyinotify python-tz python-pychart python-openssl python-egenix-mxdatetime python-pypdf python-babel python-zsi python-pypdf2 -y

# Pone trusty pero estamos usando la imagen de xenial
#RUN apt-get deb=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb

# TODO:
# Instalar locale aquí

RUN pip install openupgradelib unidecode psycogreen xlrd cssutils backports.functools_lru_cache dbfpy
RUN mkdir /opt/odoo
RUN mkdir /var/log/odoo
RUN useradd --home /opt/odoo --shell /bin/bash odoo
RUN chown odoo:odoo /opt/odoo

# Con lo siguiente, cambiamos al usuario odoo y el path donde ejecuta los
# comandos que se indiquen después.
USER odoo
WORKDIR /opt/odoo
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/ocb.git /opt/odoo

# Aquí van los repos oca
RUN mkdir /opt/odoo/oca
WORKDIR /opt/odoo/oca
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-workflow.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-financial-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/server-tools.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/web.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/reporting-engine.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/partner-contact.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/website.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/sale-workflow.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-warehouse.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-barcode.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/social.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/rma.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-payment.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-financial-tools.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-invoicing.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/purchase-workflow.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/project.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/product-variant.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/product-attribute.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/pos.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/manufacture.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/management-system.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/knowledge.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/hr.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/e-commerce.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/crm.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/contract.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/commission.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/bank-statement-reconcile.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/bank-statement-import.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/bank-payment.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-fiscal-rule.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-invoice-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-closing.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-budgeting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-analytic.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/operating-unit.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-transport.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/hr-timesheet.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/event.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/intrastat.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/sale-financial.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-tracking.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/sale-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/purchase-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/project-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/manufacture-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-consolidation.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/website-cms.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/l10n-spain.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/margin-analysis.git

# TODO:
# Repos de praxya (ya no son de instancia)

# Configuración
USER root
RUN mkdir /opt/config
RUN chown odoo:odoo /opt/config

USER odoo
# Metemos el fichero de configuración sin los valores a pasar como
# variable y luego añadimos al final las variables, usando valores por defecto:
# ${variable:-word} indicates that if variable is set then the result will be 
#    that value. If variable is not set then word will be the result.
# ${variable:+word} indicates that if variable is set then word will be the
#    result, otherwise the result is the empty string.
# Pegar fichero de configuración
ADD odoo-server.conf /opt/config/odoo-server.conf
# Introducción de variables en el .conf
RUN echo 'db_user = '${ODOO_DB_USER:-odoo} >> /opt/config/odoo-server.conf
RUN echo 'log_handler = '${LOG_HANDLER:-"[':INFO']"} >> /opt/config/odoo-server.conf
RUN echo 'log_level = '${LOG_LEVEL:-info} >> /opt/config/odoo-server.conf
RUN echo 'log_db = '${LOG_DB:-False} >> /opt/config/odoo-server.conf
# TODO: Crear un volumen para tener logs persistentes (!)
RUN echo 'logfile = '${LOGFILE:-"/var/log/odoo"} >> /opt/config/odoo-server.conf
RUN echo 'logrotate = '${LOGROTATE:-True} >> /opt/config/odoo-server.conf
RUN echo 'csv_internal_sep = '${CSV_INTERNAL_SEP:-";"} >> /opt/config/odoo-server.conf
RUN echo 'admin_passwd = '${ADMIN_PASSWD:-admin} >> /opt/config/odoo-server.conf
RUN echo 'db_host = '${DB_HOST:-localhost} >> /opt/config/odoo-server.conf
RUN echo 'db_port = '${DB_PORT:-5432} >> /opt/config/odoo-server.conf
RUN echo 'db_user = '${DB_USER:-postgres} >> /opt/config/odoo-server.conf
RUN echo 'db_password = '${DB_PASSWORD:-odoo} >> /opt/config/odoo-server.conf
RUN echo 'db_template = '${DB_TEMPLATE:-template1} >> /opt/config/odoo-server.conf
RUN echo 'db_name = '${DB_NAME:-False} >> /opt/config/odoo-server.conf
RUN echo 'db_maxconn = '${DB_MAXCONN:-64} >> /opt/config/odoo-server.conf
#RUN echo 'dbfilter = '${DBFILTER:-"^%d"} >> /opt/config/odoo-server.conf
RUN echo 'db_maxconn = '${DB_MAXCONN:-64} >> /opt/config/odoo-server.conf
RUN echo 'debug_mode = '${DEBUG_MODE:-False} >> /opt/config/odoo-server.conf
RUN echo 'email_from = '${EMAIL_FROM:-False} >> /opt/config/odoo-server.conf
RUN echo 'limit_memory_hard = '${LIMIT_MEMORY_HARD:-2684354560} >> /opt/config/odoo-server.conf
RUN echo 'limit_memory_soft = '${LIMIT_MEMORY_SOFT:-2147483648} >> /opt/config/odoo-server.conf
RUN echo 'limit_request = '${LIMIT_REQUEST:-8192} >> /opt/config/odoo-server.conf
RUN echo 'limit_time_cpu = '${LIMIT_TIME_CPU:-60} >> /opt/config/odoo-server.conf
RUN echo 'limit_time_real = '${LIMIT_TIME_REAL:-120} >> /opt/config/odoo-server.conf
RUN echo 'list_db = '${LIST_DB:-True} >> /opt/config/odoo-server.conf
# Ojo a esta variable porque este es el puerto a exponer en odoo 10,
# si no me equivoco.
RUN echo 'longpolling_port = '${LONGPOLLING_PORT:-8072} >> /opt/config/odoo-server.conf
RUN echo 'max_cron_threads = '${MAX_CRON_THREADS:-2} >> /opt/config/odoo-server.conf
RUN echo 'osv_memory_age_limit = '${OSV_MEMORY_AGE_LIMIT:-1} >> /opt/config/odoo-server.conf
RUN echo 'osv_memory_count_limit = '${OSV_MEMORY_COUNT_LIMIT:-False} >> /opt/config/odoo-server.conf
RUN echo 'pg_path = '${PG_PATH:-None} >> /opt/config/odoo-server.conf
RUN echo 'pidfile = '${PIDFILE:-None} >> /opt/config/odoo-server.conf
RUN echo 'proxy_mode = '${PROXY_MODE:-False} >> /opt/config/odoo-server.conf
RUN echo 'reportgz = '${REPORTGZ:-False} >> /opt/config/odoo-server.conf
RUN echo 'secure_cert_file = '${SECURE_CERT_FILE:-"server.cert"} >> /opt/config/odoo-server.conf
RUN echo 'secure_pkey_file = '${SECURE_pkey_FILE:-"server.pkey"} >> /opt/config/odoo-server.conf
RUN echo 'server_wide_modules = '${SERVER_WIDE_MODULES:-None} >> /opt/config/odoo-server.conf
RUN echo 'smtp_password = '${SMTP_PASSWORD:-False} >> /opt/config/odoo-server.conf
RUN echo 'smtp_port = '${SMTP_PORT:-25} >> /opt/config/odoo-server.conf
RUN echo 'smtp_server = '${SMTP_SERVER:-localhost} >> /opt/config/odoo-server.conf
RUN echo 'smtp_ssl = '${SMTP_SSL:-False} >> /opt/config/odoo-server.conf
RUN echo 'smtp_user = '${SMTP_USER:-False} >> /opt/config/odoo-server.conf
RUN echo 'syslog = '${SYSLOG:-False} >> /opt/config/odoo-server.conf
RUN echo 'test_commit = '${TEST_COMMIT:-False} >> /opt/config/odoo-server.conf
RUN echo 'test_enable = '${TEST_ENABLE:-False} >> /opt/config/odoo-server.conf
RUN echo 'test_file = '${TEST_FILE:-False} >> /opt/config/odoo-server.conf
RUN echo 'test_report_directory = '${TEST_REPORT_DIRECTORY:-False} >> /opt/config/odoo-server.conf
RUN echo 'timezone = '${TIMEZONE:-False} >> /opt/config/odoo-server.conf
RUN echo 'translate_modules = '${TRANSLATE_MODULES:-"['all']"} >> /opt/config/odoo-server.conf
RUN echo 'unaccent = '${UNACCENT:-True} >> /opt/config/odoo-server.conf
RUN echo 'without_demo = '${WITHOUT_DEMO:-True} >> /opt/config/odoo-server.conf
RUN echo 'workers = '${WORKERS:-0} >> /opt/config/odoo-server.conf
RUN echo 'xmlrpc = '${XMLRPC:-True} >> /opt/config/odoo-server.conf
RUN echo 'xmlrpc_port = '${XMLRPC_PORT:-8069} >> /opt/config/odoo-server.conf
RUN echo 'xmlrpcs = '${XMLRPCS:-True} >> /opt/config/odoo-server.conf
RUN echo 'xmlrpcs_port = '${XMLRPCS_PORT:-8071} >> /opt/config/odoo-server.conf

USER root
