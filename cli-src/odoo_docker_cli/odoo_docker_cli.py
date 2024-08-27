#!/usr/bin/env python

import click
import os

from jinja2 import Environment, FileSystemLoader, select_autoescape


def mount_upstream_callback(ctx, param, value):
    if value and not os.environ.get("ODOO_DOCKER_UPSTREAM_HOST_PATH"):
        ctx.params["upstream_path"] = click.prompt(
            "Where the main odoo/OCB code will be mounted"
            " in the host",
            default=os.environ.get(
                "ODOO_DOCKER_UPSTREAM_HOST_PATH",
                os.path.join(
                    os.path.expanduser("~"),
                    "." + ctx.params.get(
                        "project_name",
                        "odoo_docker",
                    ) + "_upstream"
                ),
            ),
            type=click.Path(
                exists=True,
                file_okay=False,
                dir_okay=True,
                writable=True,
                readable=True,
                allow_dash=False,
            )
        )
    return value


@click.command()
@click.option(
    "--project-name",
    default=os.environ.get("ODOO_DOCKER_PROJECT_NAME", "odoo_docker"),
    help="Docker Compose project name, used as a base for"
         "other defaults.",
    prompt=True,  # make conditional if set via env var
    type=str,
)
@click.option(
    "-c",
    "--comments",
    default=True,
    help="Add comments to the compose file for better context and help.",
    is_flag=True,
    prompt="Leave help comments in the compose file?",
    type=bool,
)
@click.option(
    "-d",
    "--db-filter",
    default=".*",
    help="db-filter to use. Defaults to .* but you should use a more"
    "specific on for prod, like the %d for hostname filter.",
    prompt="db-filter to use",
    show_default=True,
    type=str,
)
@click.option(
    "-o",  # as in Odoo
    "--mount-upstream",
    callback=mount_upstream_callback,
    default=False,
    help="Mount the upstream code of Odoo/OCB as a host volume "
    "in ${ODOO_DOCKER_UPSTREAM_HOST_PATH}. If the variable is not"
    " defined, you'll be prompted for a value or confirmation to use"
    " a sensible default.",
    is_flag=True,
    prompt="Mount the upstream code of Odoo/OCB as a host volume "
    "in ${ODOO_DOCKER_UPSTREAM_HOST_PATH}? (If the variable is not"
    " defined, you'll be prompted for a value or confirmation to use"
    " a sensible default)",
    show_default=True,
    type=bool,
)
@click.option(
    "-p",
    "--pudb/--no-pudb",
    default=True,
    help="Expose pudb port for console debugging option.",
    prompt="Expose 6899 port for pudb debugger sessions.",
    type=bool,
)
@click.option(
    "--repos-path",
    default=os.environ.get(
        "ODOO_DOCKER_REPOS_HOST_PATH",
        lambda: os.path.join(
            os.path.expanduser("~"),
            "." + click.get_current_context().params.get(
                "project_name",
                "odoo_docker"
            ) + "_repos"
        ),
    ),
    prompt="Where the modules repos code will be mounted"
           " in the host." if not os.environ.get(
               "ODOO_DOCKER_REPOS_HOST_PATH"
           ) else False,
    type=click.Path(
        exists=True,
        file_okay=False,
        dir_okay=True,
        writable=True,
        readable=True,
        allow_dash=False,
    ),
)
def compose(
    comments,
    db_filter,
    mount_upstream,
    project_name,
    pudb,
    repos_path,
    upstream_path=False,
    compose_filename="docker-compose.yaml"
):
    """Generate a docker compose yaml file to run the image built from
    this repository.

    Default values are oriented towards local development but you can
    get a production ready compose file too.
    """

    # Make this a function?
    # if any(lambda x: not Path(x).is_dir(), processed_variables.keys()):

    # Templating
    env = Environment(
        autoescape=select_autoescape(),
        loader=FileSystemLoader("templates"),
        trim_blocks=True,
    )
    template = env.get_template("docker-compose.yaml")
    output = template.render(
        comments=comments,
        db_filter=db_filter,
        mount_upstream=mount_upstream,
        project_name=project_name,
        pudb=pudb,
        repos_host_path=repos_path,
        upstream_path=upstream_path,  # only relevant if mount_upstream
    )
    with open(compose_filename, "x") as f:
        f.write(output)
