# Description
#   Vote on stuff!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot start vote item1, item2, item3, ...
#   hubot vote for N - where N is the choice number or the choice name
#   hubot show choices
#   hubot show votes - shows current votes
#   hubot end vote
#
# Notes:
#   None
#
# Author:
#   antonishen

module.exports = (robot) ->
  robot.voting = {}

  robot.respond /start vote (.+)$/i, (msg) ->

    if robot.voting.votes?
      msg.send "A vote is already underway"
      sendChoices (msg)
    else
      robot.voting.votes = {}
      createChoices msg.match[1]

      msg.send "Vote started"
      sendChoices(msg)

  robot.respond /end vote/i, (msg) ->
    if robot.voting.votes?
      console.log robot.voting.votes

      results = tallyVotes()

      response = "The results are..."
      for choice, index in robot.voting.choices
        response += "\n#{choice}: #{results[index]}"

      msg.send response

      delete robot.voting.votes
      delete robot.voting.choices
    else
      msg.send "There is not a vote to end"


  robot.respond /show choices/i, (msg) ->
    sendChoices(msg)

  robot.respond /show votes/i, (msg) ->
    results = tallyVotes()
    sendChoices(msg, results)

  robot.respond /vote (for )?(.+)$/i, (msg) ->
    choice = null

    re = /\d{1,2}$/i
    if re.test(msg.match[2])
      choice = parseInt msg.match[2], 10
    else
      choice = robot.voting.choices.indexOf msg.match[2]

    console.log choice

    sender = robot.brain.usersForFuzzyName(msg.message.user['name'])[0].name
