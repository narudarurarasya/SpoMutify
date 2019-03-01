# SpoMutify

A puny AppleScript (& bash) that mutes Spotify player during ads and gracefully restores the original volume when the songs are back.
Based on the assumption that the playback time of each ad is no more than a fixed time (default 60 sec.)

# Pre-requisites:
Works only for Spotify Desktop App of Mac OS X (since it uses Dictionary of the Spotify App - No APIs, permissions, nada...)

Make it executable and run it in background silently. `$ sh /path/to/SpoMutify.sh > /dev/null 2>&1 &`

# References:
1. https://jamfnation.jamfsoftware.com/discussion.html?id=5541
2. http://broadcast.oreilly.com/2009/05/itunes-dj-applescript-fade-to.html

# License:
[MIT](LICENSE.md) 

