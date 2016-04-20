module.exports = (robot) ->
  robot.hear /^(emoji)(.*)/i, (msg) ->
    emojiCounts = robot.brain.get('emojiCounts')

    emoji = (p for p of emojiCounts)
    sortedEmoji = emoji.sort (a, b) -> emojiCounts[b] - emojiCounts[a]

    msg.send (":" + e + ": - " + emojiCounts[e] for e in sortedEmoji).join("\n")

  robot.hear /\:([A-z]*)\:/ig, (msg) ->
    emojiCounts = robot.brain.get('emojiCounts')

    if emojiCounts == null
      emojiCounts = {}
    
    for match in msg.match
      emojiName = match.split(":").join("") # dumb
      emojiCounts[emojiName] ||= 0
      emojiCounts[emojiName] += 1

    robot.brain.set 'emojiCounts', emojiCounts
