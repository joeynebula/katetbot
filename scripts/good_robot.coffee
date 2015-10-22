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
  robot.hear /(.*?good jarvis|Good Jarvis .*?)/i, (msg) ->
    url = "http://orig04.deviantart.net/93ff/f/2011/252/8/b/dancing_robot_by_spacepirate11-d49bvkm.gif"
    msg.send(url)
