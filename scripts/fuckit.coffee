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
getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min
module.exports = (robot) ->
  robot.hear /(.*?Fuck it|fuck it|don't care|give a fuck.*?)/i, (msg) ->
    urls = ["http://iambrony.steeph.tp-radio.de/mlp/gif/26267__safe_rarity_animated_vulgar.gif","http://gph.is/18XZKte", "http://gph.is/15AKD3D"]
    msg.send(urls[getRandomInt(0,2)])
