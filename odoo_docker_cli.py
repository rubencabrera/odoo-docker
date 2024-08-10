import click

from jinja2 import Environment, FileSystemLoader, select_autoescape
from os import environ


@click.command()
@click.option(
    "-c",
    "--comments",
    default=True,
    help="Add comments to the compose file for better context and help.",
    is_flag=True,
    prompt="Leave help comments in the compose file?",
)
@click.option(
    "--db-filter",
    default=".*",
    help="db-filter to use. Defaults to .* but you should use a more"
    "specific on for prod, like the %d for hostname filter.",
    prompt="db-filter to use",
    show_default=True,
)
@click.option(
    "--mount-upstream",
    default=False,
    help="Mount the upstream code of Odoo/OCB as a host volume "
    "in ${ODOO_DOCKER_PROJECT_NAME}_upstream",
    is_flag=True,
    prompt="Mount the upstream code of Odoo/OCB as a host volume "
    "in ${ODOO_DOCKER_PROJECT_NAME}_upstream",
    show_default=True,
)
def compose(comments, db_filter, mount_upstream):
    env = Environment(
        autoescape=select_autoescape(),
        loader=FileSystemLoader("templates"),
        trim_blocks=True,
    )
    template = env.get_template("docker-compose.yml")
    print(
        template.render(
            compose_project_name=environ.get(
                "ODOO_DOCKER_PROJECT_NAME",
                "odoo_docker"
            ),
            comments=comments,
            db_filter=db_filter,
        )
    )
# TODO: command to generate the docker compose file for local
#       development.
#       - Get env vars with values, get from args or use defaults in
#         working directory.
