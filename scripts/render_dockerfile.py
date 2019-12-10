#!/usr/bin/env python
# -*- coding: utf-8 -*-

from jinja2 import FileSystemLoader, Environment

env = Environment(loader=FileSystemLoader('../'))
template = env.get_template('Dockerfile.jinja2')
output_from_parsed_template = template.render(
    repo_dict={
        "https://github.com/caca": "asedfasdf",
    }
)
print(output_from_parsed_template)
