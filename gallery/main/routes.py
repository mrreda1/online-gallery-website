from flask import Blueprint, render_template, url_for, request
from gallery.models import Post

main = Blueprint('main', __name__)

@main.route("/")
@main.route("/home")
def home():
    posts = Post.query.order_by(Post.post_time.desc()).paginate(page=1, per_page=12)
    return render_template('index.html', title='Home', posts=posts)


@main.route("/about")
def about():
    return render_template('about.html', title='About')

@main.route("/discovery")
def Discovery():
    page = request.args.get('page', 1, type=int)
    posts = Post.query.order_by(Post.post_time.desc()).paginate(page=page, per_page=15)
    return render_template('discovery.html', title='Discovery', posts=posts, page_num=page)
