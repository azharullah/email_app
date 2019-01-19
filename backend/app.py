import os
from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
from flask_cors import CORS, cross_origin

from users import users_api
from emails import emails_api

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = 'email_app'
mysql_db = MySQL(app)

app.register_blueprint(users_api)
app.register_blueprint(emails_api)


@app.route('/login', methods=['POST'])
@cross_origin()
def login():
  cur = mysql_db.connection.cursor()
  email = request.json.get('email')
  password = request.json.get('password')

  cur.execute('''SELECT * FROM email_app.users WHERE email = "%s" AND 
  password = "%s"''' % (email, password))
  data = cur.fetchall()
  if data:
    return jsonify({'success': True, 'data': data})
  else:
    return jsonify({'success': False,
                    'data'   : 'Invalid username and password combination'})


if __name__ == "__main__":
  app.run(threaded=True)
