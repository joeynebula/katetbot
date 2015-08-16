# Description:
#   Allows you to send emails via hubot.
#
# Dependencies:
#   "nodemailer": "0.5.2"
#
# Configuration:
#   HUBOT_EMAIL_USER - The Gmail address from which to send emails.
#   HUBOT_EMAIL_PWD  - The password associated with the account.
#   TRELLO_EMAIL_ADDRESS
#
# Commands:
#   hubot email <address@example.com> -s "<subject>" -m "<message>"
#   hubot email:kill   - Destroys ability to send email.
#   hubot email:reinit - Reinitializes the ability to send email after a kill.
#
# Author:
#   jgnewman

nodemailer    = require "nodemailer"
smtpTransport = null

# Create reusable transport method (opens pool of SMTP connections)
createTransport = ->
  smtpTransport = nodemailer.createTransport "SMTP", {
      service: "Gmail",
      auth: {
          user: process.env.HUBOT_EMAIL_USER,
          pass: process.env.HUBOT_EMAIL_PWD
      }
  }

# Create an initial transport object
createTransport()

module.exports = (robot) ->

  # Destroy the mail pool.
  robot.respond /email\:kill/i, (msg) ->
    if not smtpTransport
      msg.send 'There is currently no mail pool to kill.'
    else
      smtpTransport.close();
      smtpTransport = null;
      msg.send 'Ok. I just killed the whole mail pool.'

  # Initialize the mail pool.
  robot.respond /email\:reinit/i, (msg) ->
    if smtpTransport
      msg.send 'Email is already initialized.'
    else
      createTransport()
      msg.send 'Ok. I just initialized a mailing pool.'

  # Respond to an email command
  robot.respond /(tell joey to) (\'...*\')/i, (msg) ->
    mailto  = process.env.TRELLO_EMAIL_ADDRESS
    subject = msg.match[0]
  #  subject = subject[0].replace(/^\s*/g, '').trim().replace(/^(\'|\")|(\'|\")$/g, '')
    message = "Tello task from lauren"
    # Create an object to inform our mailing procedure
    obj = {
      from: process.env.HUBOT_EMAIL_USER,
      to: mailto,
      subject: subject or "Just a friendly update from Factals"
      text: message or ""
    }

    if not message
      msg.send "I refuse to send an email with no message body."
    else
      if not smtpTransport
        msg.send "Mail is not currently initialized."
      else
        # send mail with defined transport object
        smtpTransport.sendMail obj, (error, response) ->
          if error
            msg.send "There was an error: " + error
          else
            msg.send "Ok. Sent task to Joey."
