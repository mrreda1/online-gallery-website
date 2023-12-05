from datetime import timedelta

class Config:
    SECRET_KEY = '06e2c95fd358b62dd4b3e6f26df9c574'
    SQLALCHEMY_DATABASE_URI = 'mysql://mohamed:Stone@localhost:3306/gallery'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    REMEMBER_COOKIE_DURATION = timedelta(seconds=60)
