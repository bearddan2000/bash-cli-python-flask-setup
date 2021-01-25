#!/usr/bin/env bash

PROJECT="hello_world"

mkdir $PROJECT
apt-get install -y python3 python3-pip
pip3 uninstall virtualenv            # the latest version is broken
pip3   install virtualenv==20.0.23   # this version works

python3 -m venv venv

cat <<ACTIVATE >> venv/bin/activate

export FLASK_APP=\$VIRTUAL_ENV/../${PROJECT}/app.py
export DEBUG='True'
ACTIVATE

# activate project
source venv/bin/activate
pip install flask flask-sqlalchemy

touch $PROJECT/setup.py
cat <<SETUP > $PROJECT/setup.py
from setuptools import setup, find_packages

requires = [
    'flask',
    'flask-sqlalchemy',
    'psycopg2',
]

setup(
    name='${PROJECT}',
    version='0.0',
    description='A To-Do List built with Flask',
    author='<Your actual name here>',
    author_email='<Your actual e-mail address here>',
    keywords='web flask',
    packages=find_packages(),
    include_package_data=True,
    install_requires=requires
)
SETUP

touch $PROJECT/__init__.py $PROJECT/app.py
cat <<APP > $PROJECT/app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def ${PROJECT}():
    """Print 'Hello, world!' as the response body."""
    txt = "Hello world from {me:s} app"
    return txt.format(me = '${PROJECT}')

if __name__ == "__main__":
    app.run(host ='0.0.0.0', port = 5000, debug = True)
APP
# flask run
