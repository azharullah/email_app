from flask import Blueprint, jsonify, request, json

emails_api = Blueprint('emails_api', __name__)


@emails_api.route('/emails', methods=['POST', 'GET'])
def emails_operation():
  from app import mysql_db
  cur = mysql_db.connection.cursor()

  if request.method == 'GET':
    cur.execute('''SELECT * FROM email_app.emails WHERE deleted = 0''')
    data = cur.fetchall()
    return jsonify({'success': True, 'data': data})

  elif request.method == 'POST':
    sender_email = request.json.get('sender_email')
    receiver_emails = json.dumps(request.json.get('receiver_emails'))
    subject = request.json.get('subject')
    body = request.json.get('body')

    query = '''INSERT INTO emails (sender_email, receiver_emails, subject, 
    body) values ("%s", '%s', "%s", "%s")''' % (sender_email, receiver_emails,
                                                subject, body)
    cur.execute(query)
    cur.connection.commit()
    return jsonify({'success': True, 'data': 'Sent the email successfully'})


@emails_api.route('/emails/<string:id>', methods=['GET', 'DELETE'])
def email_operation(id):
  from app import mysql_db
  cur = mysql_db.connection.cursor()

  if request.method == 'GET':
    cur.execute('''SELECT * FROM email_app.emails WHERE id = %d''' % int(id))
    data = cur.fetchall()
    return jsonify({'success': True, 'data': data})

  elif request.method == 'DELETE':
    # Set deleted to 1
    query = '''UPDATE emails SET deleted = 1 WHERE id = %d''' % int(id)
    cur.execute(query)
    cur.connection.commit()
    return jsonify({'success': True, 'data': 'Successfully deleted the email'})


# @emails_api.route('/trash', methods=['GET'])
# def trash_operation():
#   from app import mysql_db
#   cur = mysql_db.connection.cursor()
#   cur.execute('''SELECT * FROM email_app.emails WHERE deleted = 1''')
#   data = cur.fetchall()
#   return jsonify({'success': True, 'data': data})


@emails_api.route('/emails/<string:id>/mark_as_read', methods=['POST'])
def email_mark_as_read_operation(id):
  from app import mysql_db
  cur = mysql_db.connection.cursor()

  user_email = request.json.get('email')

  # Get the email
  cur.execute('''SELECT * FROM email_app.emails WHERE id = %d''' % int(id))
  data = cur.fetchall()[0]
  seen_by = set(json.loads(data[5] or '[]'))
  seen_by.add(user_email)
  update_val = json.dumps(list(seen_by))

  query = '''UPDATE emails SET seen_by = '%s' WHERE id = %d''' % (update_val,
                                                                  int(id))
  cur.execute(query)
  cur.connection.commit()
  return jsonify({'success': True, 'data': 'Successfully deleted the email'})
