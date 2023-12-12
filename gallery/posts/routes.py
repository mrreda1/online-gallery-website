from flask import (Blueprint, abort, flash, redirect, render_template, request,
                   url_for)
from flask_login import current_user, login_required
from gallery.posts.utils import save_picture

from gallery import db
from gallery.posts.forms import PostForm
from gallery.models import Category, Post, User, UserPreferredCategory, Vote, SavedPost

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
@login_required
def post(post_id):
    post = Post.query.get_or_404(post_id)
    posts = Post.query.filter_by(category_id = post.category_id).all()
    vote_request = request.form.get('vote_request')
    save_request = request.form.get('save_request')
    up_votes = len(Vote.query.filter(Vote.post_id == post.id, Vote.vote_type == 1).all())
    down_votes = len(Vote.query.filter(Vote.post_id == post.id, Vote.vote_type == -1).all())
    votes = up_votes - down_votes
    vote_record = Vote.query.filter(Vote.user_id == current_user.id, Vote.post_id == post.id).first()
    save_record = SavedPost.query.filter(SavedPost.user_id == current_user.id, SavedPost.post_id == post.id).first()
    down = up = '#7bcae5'
    save = "None"
    if(vote_request):
        if(vote_record):
            state = vote_record.vote_type
            if(str(vote_request) == str(state)):
                db.session.delete(vote_record)
            else:
                vote_record.vote_type = vote_request
        else:
            db.session.add(Vote(user_id = current_user.id, post_id = post.id, vote_type = vote_request))
        db.session.commit()
        return redirect(url_for('posts.post', post_id = post.id))
    elif(save_request):
        if(save_record):
            db.session.delete(save_record)
        else:
            db.session.add(SavedPost(user_id = current_user.id, post_id = post.id))
        db.session.commit()
        return redirect(url_for('posts.post', post_id = post.id))
    if(save_record):
        save = "#FAF0F0"
    if(vote_record):
        state = vote_record.vote_type
        if(state == 1):
            up = '#FF161E'
        else:
            down = '#FF161E'

    user = User.query.get(post.publisher_id)
    return render_template('image.html', title=post.title, post=post, user=user, posts=posts, votes=votes, up=up, down=down, save=save)

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

@posts.route("/categories", methods=['POST', 'GET'])
@login_required
def categories():
    categories = Category.query.all()
    if request.form.get('submit'):
        cat_list = list(filter(None, [cat.id if request.form.get(cat.id) else None for cat in categories]))
        if(len(cat_list) < 5):
            flash("You must choose at least 5 categories", "danger")
            return redirect(url_for('posts.categories'))
        for ucat in UserPreferredCategory.query.filter_by(user_id=current_user.id).all():
            db.session.delete(ucat)
        for cat_id in cat_list:
            db.session.add(UserPreferredCategory(user_id=current_user.id, category_id=cat_id))
        db.session.commit()
        return redirect(url_for('main.home'))

    return render_template('category.html', categories=categories)
