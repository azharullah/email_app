from flask import Blueprint, jsonify

users_api = Blueprint('users_api', __name__)


@users_api.route('/users')
def userslist():
  from app import mysql_db
  cur = mysql_db.connection.cursor()
  cur.execute('''SELECT * FROM email_app.users''')
  data = cur.fetchall()
  return jsonify({'success': True, 'data': data})


@users_api.route('/user/<string:email>/sent')
def sent_email(email):
  from app import mysql_db
  cur = mysql_db.connection.cursor()
  cur.execute('''SELECT * FROM email_app.emails WHERE sender_email = %s AND 
  deleted = 0''' % email)
  data = cur.fetchall()
  return jsonify({'success': True, 'data': data})


@users_api.route('/user/<string:email>/inbox')
def inbox_email(email):
  from app import mysql_db
  cur = mysql_db.connection.cursor()
  cur.execute('''SELECT * FROM email_app.emails where JSON_CONTAINS(
  receiver_emails, '%s', '$') AND deleted = 0''' % email)
  data = cur.fetchall()
  return jsonify({'success': True, 'data': data})


@users_api.route('/user/<string:email>/drafts')
def drafts_email(email):
  from app import mysql_db
  cur = mysql_db.connection.cursor()
  cur.execute('''SELECT * FROM email_app.drafts''')
  data = cur.fetchall()
  return jsonify({'success': True, 'data': data})


@users_api.route('/user/<string:email>/trash')
def trash_email(email):
  from app import mysql_db
  cur = mysql_db.connection.cursor()
  cur.execute(
    '''SELECT * FROM email_app.emails WHERE (sender_email = %s OR 
    JSON_CONTAINS(receiver_emails, '%s', '$')) AND deleted = 1''' % (email,
                                                                    email))
  data = cur.fetchall()
  return jsonify({'success': True, 'data': data})
