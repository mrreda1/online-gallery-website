#!/usr/bin/python3

from flask import flash, redirect, render_template, url_for
from forms import RegistrationForm, LoginForm
from dbconnect import app, mysql

posts = [
    {
        'author': 'Mohamed Reda',
        'title': 'Blog Post 1',
        'content': 'First post content',
        'date_posted': 'NOV 29, 2023'
    },
    {
        'author': 'Mohamed Seif',
        'title': 'Blog post 2',
        'content': 'Second post content',
        'date_posted': 'NOV 30, 2023'
    },
    {
        'author': 'Rawan Hesham',
        'title': 'Blog post 3',
        'content': 'Third post content',
        'date_posted': 'DEC 1, 2023'
    }
]


@app.route("/")
@app.route("/home")
def home():
    return render_template('main.html', posts=posts, title='Home')


@app.route("/about")
def about():
    return render_template('about.html', title='About')


@app.route("/register", methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        cur = mysql.cursor()
        cur.execute(f"INSERT INTO users (username, email, password) VALUES ('{form.username.data}', '{form.email.data}', '{form.password.data}')")
        mysql.commit()
        cur.close()

        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('home'))

    return render_template('register.html', title='Register', form=form)


@app.route("/login", methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        flash('Welcome back!', 'success')
        return redirect(url_for('home'))
    return render_template('login.html', title='Log In', form=form)


if __name__ == '__main__':
    app.run(debug=True)
