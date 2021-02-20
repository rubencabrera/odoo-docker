# DOCKER image to run odoo 12 with Odoo Community Backports and OCA addons
FROM debian:stretch
MAINTAINER Rubén Cabrera Martínez <dev@rubencabrera.es>
EXPOSE 8069 8071 8072
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install \
    software-properties-common=0.96.20.2-1 \
    wget=1.18-5+deb9u3 \
    gnupg2=2.1.18-8~deb9u4 \
    -y

RUN add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" -y; \
    wget --quiet -O - https://postgresql.org/media/keys/ACCC4CF8.asc | \
    apt-key add -

RUN apt-get update && apt-get install \
        git=1:2.11.0-3+deb9u5 \
        libssl1.0-dev=1.0.2u-1~deb9u1 \
        locales=2.24-11+deb9u4 \
        net-tools=1.60+git20161116.90da8a0-1 \
        node-clean-css=1.0.12-2 \
        node-less=1.6.3~dfsg-2 \
        postgresql-client-9.6=9.6.14-1.pgdg90+1 \
        python3-apt=1.4.0~beta3 \
        python3-babel=2.3.4+dfsg.1-2 \
        python3-cups=1.9.73-1 \
        python3-dateutil=2.5.3-2 \
        python3-decorator=4.0.11-1 \
        python3-dev=3.5.3-1 \
        python3-docutils=0.13.1+dfsg-2 \
        python3-feedparser=5.1.3-3 \
        python3-gevent=1.1.2-1 \
        python3-geoip=1.3.2-1+b2 \
        python3-jinja2=2.8-1 \
        python3-lxml=3.7.1-1 \
        python3-mako=1.0.6+ds1-2 \
        python3-mock=2.0.0-3 \
        python3-openid=3.0.9-1 \
        python3-openssl=16.2.0-1 \
        python3-passlib=1.7.0-2 \
        python3-pip=9.0.1-2+deb9u1 \
        python3-psutil=5.0.1-1 \
        python3-psycopg2=2.8.4-1~pgdg90+1 \
        python3-pydot=1.0.28-2 \
        python3-pyinotify=0.9.6-1 \
        python3-pyldap=2.4.25.1-2 \
        python3-pyparsing=2.1.10+dfsg1-1 \
        python3-pypdf2=1.26.0-2 \
        python3-qrcode=5.3-1 \
        python3-renderpm=3.3.0-2 \
        python3-reportlab=3.3.0-2 \
        python3-requests=2.12.4-1 \
        python3-simplejson=3.10.0-1 \
        python3-tz=2016.7-0.3 \
        python3-unicodecsv=0.14.1-1 \
        python3-unittest2=1.1.0-6.1 \
        python3-vatnumber=1:1.2-7 \
        python3-vobject=0.9.3-3 \
        python3-watchdog=0.8.3-2 \
        python3-werkzeug=0.16.0+dfsg1-1 \
        python3-yaml=3.12-1 \
        xauth=1:1.0.9-1+b2 \
        xfonts-75dpi=1:1.0.4+nmu1 \
        xfonts-base=1:1.0.4+nmu1 \
        xfonts-utils=1:7.7+4 \
        -y

# Pone trusty pero estamos usando la imagen de xenial
#RUN apt-get deb=https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
#RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb

RUN pip3 install \
        backports.functools_lru_cache \
        bokeh \
        cssutils \
        dbfpy \
        html2text \
        libsass \
        odoorpc \
        ofxparse \
        openupgradelib \
        num2words \
        pandas \
        psycogreen \
        twilio \
        unidecode \
        xlrd \
        zeep \
        zklib
RUN mkdir /opt/odoo; mkdir /var/log/odoo; mkdir /var/lib/odoo; mkdir /opt/repos && mkdir /opt/repos/oca
RUN mkdir  -p /opt/repos/other
RUN useradd --home /opt/odoo --shell /bin/bash odoo
RUN chown -R odoo:odoo /opt/odoo; chown -R odoo:odoo /var/lib/odoo; \
    chown -R odoo:odoo /var/log/odoo; chown -R odoo:odoo /opt/repos

# Con lo siguiente, cambiamos al usuario odoo y el path donde ejecuta los
# comandos que se indiquen después.
USER odoo
WORKDIR /opt/odoo
RUN git clone --branch 12.0 --depth 1 https://github.com/oca/ocb.git /opt/odoo

# Odoo Community Association repositories
WORKDIR /opt/repos/oca
RUN git clone --branch 12.0 --depth 1 https://github.com/oca/account-analytic.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-budgeting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-closing.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-consolidation.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-invoice-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-invoicing.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-financial-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-financial-tools.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-fiscal-rule.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/account-payment.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/bank-payment.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/bank-statement-import.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/bank-statement-reconcile.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/commission.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/community-data-files.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/contract.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/crm.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/e-commerce.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/event.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/hr.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/hr-timesheet.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/intrastat.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/knowledge.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/l10n-spain.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/management-system.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/manufacture.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/manufacture-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/margin-analysis.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/operating-unit.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/partner-contact.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/pos.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/product-attribute.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/product-variant.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/project.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/project-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/purchase-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/purchase-workflow.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/reporting-engine.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/rma.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/sale-financial.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/sale-reporting.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/sale-workflow.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/server-tools.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/social.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-barcode.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-tracking.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-transport.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-warehouse.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-workflow.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/web.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/website.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/website-cms.git;

# Other repos, specify folder name so this doesn't get messy with all repos
# named odoo-addons or similar
WORKDIR /opt/repos/other
RUN git clone --branch 12.0 --depth 1 https://github.com/rubencabrera/odoo-addons.git rubencabrera;

# Configuración
USER root
RUN mkdir /opt/config
COPY ./odoo-server.conf /opt/config/odoo-server.conf
ENV OPENERP_SERVER /opt/config/odoo-server.conf

RUN chown -R odoo:odoo /opt/config
RUN sed -i '/^#.*Storage/s/^#//' /etc/systemd/journald.conf
#RUN mkdir -p /var/lib/odoo \
    #&& chown -R odoo /var/lib/odoo
#VOLUME ["/var/lib/odoo"]
# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons
# for users addons
RUN mkdir -p /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /var/lib/odoo
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chown -R odoo:odoo /opt/entrypoint.sh
RUN ["chmod", "+x", "/opt/entrypoint.sh"]

USER odoo
ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/opt/odoo/odoo-bin"]
