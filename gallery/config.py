from datetime import timedelta

class Config:
    SECRET_KEY = '16619cdf9dfd997ce0cec97fe5ce3233'
    SQLALCHEMY_DATABASE_URI = 'mysql://mohamed:Stone@localhost:3306/gallery'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    REMEMBER_COOKIE_DURATION = timedelta(seconds=60)
