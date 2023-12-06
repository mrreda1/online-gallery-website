from flask import (Blueprint, abort, flash, redirect, render_template, request,
                   url_for)
from flask_login import current_user, login_required
from gallery.posts.utils import save_picture

from gallery import db
from gallery.posts.forms import PostForm
from gallery.models import Category, Post, User

posts = Blueprint('posts', __name__)

@posts.route("/post/new", methods=['GET', 'POST'])
@login_required
def new_post():
    form = PostForm()
    form.category.choices = [cat.cat_name for cat in Category.query.all()]
    if form.validate_on_submit():
        title = form.title.data
        description = form.description.data
        image_file = save_picture(form.image_file.data)
        category = Category.query.filter_by(cat_name=form.category.data).first()
        db.session.add(Post(title=title, description=description, category_id=category.id, publisher_id=current_user.id, image_file=image_file))
        db.session.commit()
        flash("Your post has been created!", 'success')
        return redirect(url_for('main.home'))
    return render_template('upload.html', title='New Post', form=form)

@posts.route("/post/<int:post_id>", methods=['GET', 'POST'])
def post(post_id):
    post = Post.query.get_or_404(post_id)
    posts = Post.query.filter_by(category_id = post.category_id).all()
    user = User.query.get(post.publisher_id)
    return render_template('image.html', title=post.title, post=post, user=user, posts=posts)

@posts.route("/post/<int:post_id>/delete", methods=['POST', 'GET'])
@login_required
def delete_post(post_id):
    post = Post.query.get_or_404(post_id)
    if current_user.id != post.publisher_id:
        abort(403)
    db.session.delete(post)
    db.session.commit()
    flash('Your post has been deleted!', 'success')
    return redirect(url_for('main.home'))
