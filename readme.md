### This is a basic, trimmed down, web based version of gmail.

#### The server side (backend) exposes REST API's for the clients (the UI in this case) for communication

#### Features:

(All the UI and backend code has been implemented for these)
1) Login
2) The mail box view upon login has 4 sections (Inbox, Sent, Drafts, Trash)
3) Compose and send a mail to one/multiple people with a subject and body
4) Differentiation between read and unread mails and marking a mail as read per user when it is opened for the first time
5) Deleting a mail so that it moves to the trash

#### Not done / Yet to be implemented

1) Saving a mail as draft
2) Forwarding a mail (DB schema is in place, code needs to be implemented)
3) Replying to a mail (DB schema is in place, code needs to be implemented)

#### To run the application

##### Importing the DB data
```bash
mysql -u username -p email_app < db_data.sql
```

##### Starting up the server:

1) The db password needs to be set as an env variable `MYSQL_PASSWORD`
2) Run ```cd backend && python app.py``` to start the server 

##### Bringing up the UI

1) Open up the `ui/index.html` in the browser
2) Note: For the UI to work, cookies have to be enabled as the app uses browser `localstorage` to store the user details