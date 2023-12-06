from datetime import datetime

from flask_login import UserMixin

from gallery import db, login_manager


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class User(db.Model, UserMixin):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    firstname = db.Column(db.String(30), nullable=False)
    lastname = db.Column(db.String(30), nullable=False)
    username = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    pfp = db.Column(db.String(50), server_default='default_pfp.jpg', nullable=False)
    
    preferred_categories = db.relationship('UserPreferredCategory', backref='user', lazy=True, cascade='all, delete-orphan')
    saved_posts = db.relationship('SavedPost', backref='user', lazy=True, cascade='all, delete-orphan')
    votes = db.relationship('Vote', backref='user', lazy=True, cascade='all, delete-orphan')

    def __repr__(self):
        return f'<User id={self.id} username={self.username}>'

class Category(db.Model, UserMixin):
    __tablename__ = 'categories'
    id = db.Column(db.String(10), primary_key=True)
    cat_name = db.Column(db.String(50), nullable=False)
    cat_image = db.Column(db.String(50), server_default='default_cat.jpg', nullable=False)

    posts = db.relationship('Post', backref='category', lazy=True, cascade='all, delete-orphan')

    def __repr__(self):
        return f'<Category id={self.id} cat_name={self.cat_name}>'

class Post(db.Model, UserMixin):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    post_time = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    image_file = db.Column(db.String(50), nullable=False)
    
    category_id = db.Column(db.String(10), db.ForeignKey('categories.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False)
    publisher_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), nullable=False)

    votes = db.relationship('Vote', backref='post', lazy=True, cascade='all, delete-orphan')

    def __repr__(self):
        return f'<Post id={self.id} title={self.title}>'

class UserPreferredCategory(db.Model, UserMixin):
    __tablename__ = 'user_preferred_categories'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), primary_key=True)
    category_id = db.Column(db.String(10), db.ForeignKey('categories.id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True)

    def __repr__(self):
        return f'<UserPreferredCategory user_id={self.user_id} category_id={self.category_id}>'

class SavedPost(db.Model, UserMixin):
    __tablename__ = 'saved_posts'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('posts.id', ondelete='CASCADE'), primary_key=True)

    def __repr__(self):
        return f'<SavedPost user_id={self.user_id} post_id={self.post_id}>'

class Vote(db.Model, UserMixin):
    __tablename__ = 'votes'
    user_id = db.Column(db.Integer, db.ForeignKey('users.id', ondelete='CASCADE'), primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('posts.id', ondelete='CASCADE'), primary_key=True)
    vote_type = db.Column(db.SmallInteger, nullable=False)

    def __repr__(self):
        return f'<Vote user_id={self.user_id} post_id={self.post_id} vote_type={self.vote_type}>'
