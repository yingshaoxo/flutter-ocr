#!/usr/bin/env python

from setuptools import Extension
from setuptools.command.build_ext import build_ext

from setuptools import setup, find_packages
from os.path import dirname, join, abspath

version = '1.0'

# main
file_path = join(abspath(dirname(__file__)), "README.md")
with open(file_path) as f:
    long_description = f.read()

# Let's first try to install the normal version
setup(name='flutter_ocr_server',
      version=version,
      description='do ocr on Linux',
      long_description=long_description,
      long_description_content_type='text/markdown',
      classifiers=[
          'Operating System :: POSIX :: Linux',
          'Programming Language :: Python :: 3',
          'Topic :: System',
          'License :: OSI Approved :: GNU General Public License v3 (GPLv3)'
      ],
      keywords='Linux system ocr',
      url='https://github.com/yingshaoxo/flutter-ocr',
      author='yingshaoxo',
      author_email='yingshaoxo@gmail.com',
      license='GPLv3',
      install_requires=[
          'setuptools',
      ],
      include_package_data=False,
      packages=find_packages(),
      scripts=['ocr_server.py'],
      )
