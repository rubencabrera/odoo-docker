# DOCKER para odoo 10 de Odoo Community Backports
FROM ubuntu:16.04
MAINTAINER Rubén Cabrera Martínez <rcabrera@praxya.com>
EXPOSE 8069

RUN apt-get install git xauth python-pip python-cups python-jinja2 python-unicodecsv python-psycopg2 python-simplejson python-lxml python-imaging python-yaml python-reportlab python-mako python-werkzeug python-dateutil python-unittest2 python-mock python-openid python-docutils python-feedparser python-psutil python-pydot python-vatnumber python-vobject python-xlwt python-ldap python-requests python-decorator python-passlib python-babel python-gevent locales python-webdav python-gdata xfonts-75dpi python-apt xfonts-base python-pyparsing xfonts-utils python-dev python-libxslt1 python-psycopg2 python-geoip python-pybabel python-pyinotify python-tz python-pychart python-openssl python-egenix-mxdatetime python-pypdf python-babel python-zsi python-pypdf2

# Pone trusty pero estamos usando la imagen de xenial
RUN apt deb=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb

# TODO:
# Instalar locale aquí

RUN sudo pip install openupgradelib unidecode psycogreen xlrd cssutils backports.functools_lru_cache dbfpy
RUN mkdir /opt/odoo
RUN mkdir /var/log/odoo
RUN useradd --home /opt/odoo --shell /bin/bash odoo

# Con lo siguiente, cambiamos al usuario odoo y el path donde ejecuta los
# comandos que se indiquen después.
USER odoo
WORKDIR /opt/odoo
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/ocb.git /opt/odoo

# Aquí van los repos oca
RUN mkdir /opt/odoo/oca
WORKDIR /opt/odoo/oca
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/ocb.git
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
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/margin-analysis.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/stock-logistics-tracking.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/sale-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/purchase-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/project-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/manufacture-reporting.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/account-consolidation.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/website-cms.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/l10n-spain.git
RUN git clone --branch 10.0 --depth 1 https://github.com/oca/margin-analysis.git

# Repos de praxya (ya no son de instancia)


RUN mkdir /opt/config
# Pegar fichero de configuración
