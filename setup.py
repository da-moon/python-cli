#!/usr/bin/env python3

from setuptools import setup
from codecs import open
from os import path
readme_file = path.join(path.dirname(__file__), 'README.md')
if path.isfile(readme_file):
    with open(readme_file, encoding='utf-8') as f:
        long_description = f.read()
else:
    long_description = 'template for python datascience projects.'
version_file = path.join(path.dirname(
    __file__), 'project_template/_version.py')
with open(version_file, 'r') as f:
    exec(f.read())

setup(
    name='project_template',
    version=Version,
    description='template for python datascience projects',
    long_description=long_description,
    url='',
    author='',
    author_email='',
    license='MIT',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Topic :: Scientific/Engineering',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.7',
    ],
    keywords=' optimization engineering',
    packages=['project_template',
              'project_template.util',
              'project_template.basic_subcommand',
              ],
    entry_points={
        'console_scripts': [
            'project_template=project_template.__main__:run_project_template',
        ],
    },
)
