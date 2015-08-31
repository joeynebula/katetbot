# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Author:
#   Joey

module.exports = (robot) ->
  robot.hear /(.*?bad jarvis|Bad Jarvis .*?)/i, (msg) ->
    url = "http://i.imgur.com/HsQhqPA.png"
    msg.send(url)
