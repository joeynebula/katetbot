# Description:
#   Sends a message when to a room when button is pressed
# URLS:
#   POST /hubot/notify/<room> (message=<message>)

module.exports = (robot) ->
  robot.router.post '/hubot/button-press/:room', (req, res) ->
    room = req.params.room
    message = "Joey pushed his damn button again."
    robot.messageRoom room, message
    res.end()
