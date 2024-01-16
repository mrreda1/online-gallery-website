#!/usr/bin/python
from gallery import create_app

app = create_app()

from gallery.models import db

db.drop_all()
db.create_all()
