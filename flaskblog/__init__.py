from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from datetime import timedelta

app = Flask(__name__)
app.config['SECRET_KEY'] = '16619cdf9dfd997ce0cec97fe5ce3233'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://mohamed:Stone@localhost:3306/testdb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['REMEMBER_COOKIE_DURATION'] = timedelta(seconds=60)

bcrypt = Bcrypt(app)
db = SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'
login_manager.login_message_category = 'info'

app.app_context().push()

from flaskblog import routes
