from flask import Flask
import mysql.connector

mysql = mysql.connector.connect(host="localhost", port=3306,
                                user="mohamed", password="",
                                database="dummyDB")
app = Flask(__name__)

app.secret_key = 'super_secret_key'
