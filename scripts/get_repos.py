#!/usr/bin/env python
# -*- coding: utf-8 -*-

from github import Github, GithubException
import logging
from dev_token import token

_logger = logging.getLogger(__name__)
_logger.setLevel(logging.DEBUG)


# Add optional ConsoleHandler
ch = logging.StreamHandler()
ch.name = 'Console Logger'
ch.level = logging.DEBUG
_logger.addHandler(ch)

g = Github(token)


def get_all_oca_repos():
    repos = g.get_organization("OCA").get_repos()
    _logger.debug("Number of repos found for OCA: %d" % repos.totalCount)
    return repos


well_known_repos = [
    "https://github.com/OCA/account-analytic.git",
    "https://github.com/OCA/account-budgeting.git",
    "https://github.com/OCA/account-closing.git",
    "https://github.com/OCA/account-consolidation.git",
    "https://github.com/OCA/account-invoice-reporting.git",
    "https://github.com/OCA/account-invoicing.git",
    "https://github.com/OCA/account-financial-reporting.git",
    "https://github.com/OCA/account-financial-tools.git",
    "https://github.com/OCA/account-fiscal-rule.git",
    "https://github.com/OCA/account-payment.git",
    "https://github.com/OCA/bank-payment.git",
    "https://github.com/OCA/bank-statement-import.git",
    "https://github.com/OCA/bank-statement-reconcile.git",
    "https://github.com/OCA/commission.git",
    "https://github.com/OCA/community-data-files.git",
    "https://github.com/OCA/contract.git",
    "https://github.com/OCA/crm.git",
    "https://github.com/OCA/e-commerce.git",
    "https://github.com/OCA/event.git",
    "https://github.com/OCA/hr.git",
    "https://github.com/OCA/hr-timesheet.git",
    "https://github.com/OCA/intrastat.git",
    "https://github.com/OCA/knowledge.git",
    "https://github.com/OCA/l10n-spain.git",
    "https://github.com/OCA/management-system.git",
    "https://github.com/OCA/manufacture.git",
    "https://github.com/OCA/manufacture-reporting.git",
    "https://github.com/OCA/margin-analysis.git",
    "https://github.com/OCA/operating-unit.git",
    "https://github.com/OCA/partner-contact.git",
    "https://github.com/OCA/pos.git",
    "https://github.com/OCA/product-attribute.git",
    "https://github.com/OCA/product-variant.git",
    "https://github.com/OCA/project.git",
    "https://github.com/OCA/project-reporting.git",
    "https://github.com/OCA/purchase-reporting.git",
    "https://github.com/OCA/purchase-workflow.git",
    "https://github.com/OCA/reporting-engine.git",
    "https://github.com/OCA/rma.git",
    "https://github.com/OCA/sale-financial.git",
    "https://github.com/OCA/sale-reporting.git",
    "https://github.com/OCA/sale-workflow.git",
    "https://github.com/OCA/server-tools.git",
    "https://github.com/OCA/social.git",
    "https://github.com/OCA/stock-logistics-barcode.git",
    "https://github.com/OCA/stock-logistics-tracking.git",
    "https://github.com/OCA/stock-logistics-transport.git",
    "https://github.com/OCA/stock-logistics-warehouse.git",
    "https://github.com/OCA/stock-logistics-workflow.git",
    "https://github.com/OCA/web.git",
    "https://github.com/OCA/website.git",
    "https://github.com/OCA/website-cms.git",
    ]


def create_repo_dict():
    # TODO: actually make this variable
    branch = "12.0"
    repo_dict = dict()
    for repo in get_all_oca_repos():
        #  print(repo.clone_url)
        #  print(repo.name)
        try:
            if repo.clone_url in well_known_repos:
                repo_dict[repo.clone_url] = repo.get_branch(branch).commit.sha
            #  print(repo.get_branch(branch).commit)
        except GithubException:
            #  print("This repo has no %s branch" % branch)
            pass
    return repo_dict


def main():
    print(create_repo_dict())


if __name__ == "__main__":
    main()
