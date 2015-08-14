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
  robot.hear /(.*?Fuck it|fuck it .*?)/i, (msg) ->
    url = "http://iambrony.steeph.tp-radio.de/mlp/gif/26267__safe_rarity_animated_vulgar.gif"
    msg.send(url)
