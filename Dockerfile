# DOCKER image to run odoo 12 with Odoo Community Backports and OCA addons
FROM rubencabrera/odoo-base-image:12.2.9
MAINTAINER Rubén Cabrera Martínez <dev@rubencabrera.es>
EXPOSE 8069 8071 8072
ENV LANG C.UTF-8

RUN mkdir /opt/odoo; \
    mkdir /var/log/odoo; \
    mkdir /var/lib/odoo; \
    mkdir /opt/repos; \
    mkdir -p /opt/repos/oca; \
    mkdir -p /opt/repos/other
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
    git clone --branch 12.0 --depth 1 https://github.com/oca/connector-telephony.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/contract.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/crm.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/data-protection.git; \
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
    git clone --branch 12.0 --depth 1 https://github.com/oca/server-ux.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/social.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-barcode.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-tracking.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-transport.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-warehouse.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/stock-logistics-workflow.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/web.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/website.git; \
    git clone --branch 12.0 --depth 1 https://github.com/oca/website-cms.git;


WORKDIR /opt/repos/other
RUN git clone --branch 12.9.3 --depth 1 https://github.com/rubencabrera/odoo-addons.git rubencabrera-odoo-addons;

# Configuración
WORKDIR /opt
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
