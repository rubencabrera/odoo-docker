import click
import os

from jinja2 import Environment, FileSystemLoader, select_autoescape
from pathlib import Path


def check_environment_variable(
    variable_name: str,
    default_value: str,
    help: str
) -> str:
    """Check if an env var used in the template is defined and prompt for
    confirmation if it isn't.
    """
    return os.environ.get(variable_name, False) or click.prompt(
        f"{variable_name} environment variable is not defined,"
        f" default value is: {default_value} . Introduce your own"
        " value or press ENTER to use the default",
        default=default_value,
        type=str,
    )


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
    "-d",
    "--db-filter",
    default=".*",
    help="db-filter to use. Defaults to .* but you should use a more"
    "specific on for prod, like the %d for hostname filter.",
    prompt="db-filter to use",
    show_default=True,
)
@click.option(
    "-o",  # as in Odoo
    "--mount-upstream",
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
)
@click.option(
    "-p",
    "--pudb/--no-pudb",
    default=True,
    help="Expose pudb port for console debugging option.",
    prompt="Expose 6899 port for pudb debugger sessions.",
)
def compose(comments, db_filter, mount_upstream, pudb):
    """Generate a docker compose yaml file to run the image built from
    this repository.

    Default values are oriented towards local development but you can
    get a production ready compose file too.
    """

    try:
        # All this crap and the check function must be doable with click:
        compose_env_vars = {
            "odoo_docker_project_name": {
                "default": "odoo_docker",
                "help": "Docker Compose project name, used as a base for"
                        "other defaults.",
            },
            "odoo_docker_repos_host_path": {
                "default": os.path.join(
                    os.environ["HOME"],
                    "." + os.environ.get(
                        "ODOO_DOCKER_PROJECT_NAME",
                        "odoo_docker"
                    ) + "_repos",
                ),
            }
        }

    except KeyError:
        raise RuntimeError("No $HOME env var defined.")

    # Call the check variables for prompts
    processed_variables = {
        variable_name: check_environment_variable(
            variable_name=variable_name,
            default_value=variable_props.get("default"),
            help=variable_props.get("help"),
        ) for variable_name, variable_props in compose_env_vars.items()
    }

    # Make this a function?
    # if any(lambda x: not Path(x).is_dir(), processed_variables.keys()):
    env = Environment(
        autoescape=select_autoescape(),
        loader=FileSystemLoader("templates"),
        trim_blocks=True,
    )
    template = env.get_template("docker-compose.yml")
    print(
        template.render(
            #  compose_project_name=odoo_docker_project_name,
            comments=comments,
            db_filter=db_filter,
            #  odoo_docker_repos_host_path=odoo_docker_repos_host_path,
            pudb=pudb,
            **processed_variables,
        )
    )
