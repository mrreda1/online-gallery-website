from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_login import current_user, login_required, login_user, logout_user
import flask_login
from gallery import bcrypt, db
from gallery.users.forms import LoginForm, RegistrationForm, UpdateAccountForm, UpdateSecurityForm
from gallery.models import Post, SavedPost, User, Vote
from gallery.users.utils import save_picture

users = Blueprint('users', __name__)

@users.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = RegistrationForm()
    if form.validate_on_submit():
        firstname = str(form.firstname.data)
        lastname = str(form.lastname.data)
        username = str(form.username.data).lower()
        email = str(form.email.data).lower()
        hashed_pwd = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = User(username=username, email=email, password=hashed_pwd, firstname=firstname, lastname=lastname)
        db.session.add(user)
        db.session.commit()
        flask_login.login_user(user)
        flash(f'Your account has been created!', 'success')
        return redirect(url_for('posts.categories'))

    return render_template('register.html', title='Register', form=form)


@users.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if (user and bcrypt.check_password_hash(user.password, form.password.data)):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            if next_page:
                return redirect(next_page)
            else:
                flash('Welcome back!', 'success')
                return redirect(url_for('main.home'))
        else:
            flash('Incorrect Email or Password.', 'danger')
    return render_template('login.html', title='Log In', form=form)

@users.route("/update-profile", methods=['GET', 'POST'])
@login_required
def updateProfile():
    form = UpdateAccountForm()
    security = UpdateSecurityForm()

    if form.validate_on_submit():
        if form.picture.data:
            picture_file = save_picture(form.picture.data)
            current_user.pfp = picture_file
        if(not ((not form.picture.data) and form.email.data == current_user.email and
            form.username.data == current_user.username and form.firstname.data == current_user.firstname and
            form.lastname.data == current_user.lastname)):

            print(form.picture.data)
            current_user.username = str(form.username.data).lower()
            current_user.email = str(form.email.data).lower()
            current_user.firstname = str(form.firstname.data)
            current_user.lastname = str(form.lastname.data)
            db.session.commit()
            flash('Your account has been updated!', 'success')
        return redirect(url_for('users.updateProfile'))
    if security.validate_on_submit():
        current_user.password = bcrypt.generate_password_hash(security.new.data).decode('utf-8')
        db.session.commit()
        flash('Password changed!', 'success')
        return redirect(url_for('users.updateProfile'))
    if request.method == 'GET' or security.submit.data:
        form.username.data = current_user.username
        form.email.data = current_user.email
        form.firstname.data = current_user.firstname
        form.lastname.data = current_user.lastname
    pfp = url_for('static', filename='profile_pics/' + current_user.pfp)
    return render_template('userinfo.html', title='Edit Profile', imagepfp = pfp, form=form, security = security)

@users.route("/user/<string:username>", methods=['GET'])
@login_required
def userProfile(username):
    user = User.query.filter_by(username=username).first_or_404()
    uploaded_posts = Post.query.filter_by(publisher_id=user.id).all()
    uploaded_images = len(uploaded_posts)
    saved_posts_id = SavedPost.query.filter_by(user_id=user.id).all()
    saved_posts = [Post.query.get(int(post.post_id)) for post in saved_posts_id]
    votes = len(Vote.query.filter_by(user_id=user.id).all())
    return render_template('profile.html', user=user, title=username, uploaded_images=uploaded_images,
                           votes=votes, uploaded_posts=uploaded_posts, saved_posts=saved_posts)


@users.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.home'))
