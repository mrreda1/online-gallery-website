from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, TextAreaField, SelectField
from flask_wtf.file import FileField, FileAllowed
from wtforms.validators import DataRequired
from gallery.models import Category


class PostForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired()])
    description = TextAreaField('Description', validators=[DataRequired()])
    image_file = FileField('Photo', validators=[FileAllowed(['jpg', 'png', 'jpeg'])])
    category = SelectField('Select category', choices=[])
    submit = SubmitField('Upload')
