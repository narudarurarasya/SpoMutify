#!/bin/bash

# Keep on checking (forever) whether Spotify is running...
while :
do

	# Process check to see if Spotify is running...
	if ps aux | grep -v grep | grep Spotify.app > /dev/null
	then

	# Specify to run it as an OS applesctipt specifying it ends at EOT
	/usr/bin/osascript <<EOT


	-- set the avg. duration of an ad (in ms). Default (60000 ms == 60 sec.)
	set ad_duration to 60000

	-- set the wait interval (in seconds) for constantly checking for ads in loop
	set delay_timer to 1

	repeat until application "Spotify" is not running

		-- Boolean switch to toggle when an ad shows up
		set is_ad to "No"

		tell application "Spotify"

			-- Get the volume of Spotify player (Not system Volume)
			set originalVolume to get sound volume
			set trackTime to get duration of current track

			if trackTime ≤ ad_duration then
				set is_ad to "yes"
				-- delay delay_timer
				-- display notification "ad duration: " & trackTime & ", Vol: " & currentVolume & " -> 10 "

				-- Fade volume gracefully
				set currentVolume to get sound volume
				-- display notification "before reducing: " & currentVolume
				if currentVolume is not 0 then
					repeat with i from currentVolume to 1 by -1 -- Adjust to taste; bigger numbers fade faster
						set sound volume to i
						delay 0.02 -- Adjust this to change fadeout duration (delete this line on slower Macs)
					end repeat
				end if

				-- display notification "after reducing: " & sound volume
			end if

			-- Check periodically whether the ads are still playing...
			repeat while trackTime ≤ ad_duration
				-- display notification "Ad going on... delaying " & delay_timer & " secs. "
				delay delay_timer
				set trackTime to get duration of current track
			end repeat

			if is_ad is "yes" then
				set currentVolume to get sound volume

				-- display notification "Before increasing: " & currentVolume
				if currentVolume = 0 then
					-- Increase Volume gracefully
					repeat with i from currentVolume to originalVolume by 1
						set sound volume to i
						delay 0.02
					end repeat
				end if
				-- display notification "After increasing: " & sound volume
			end if
		end tell

		delay delay_timer
	end repeat

EOT
fi
# sleep for 5 seconds and check again...
sleep 5
done
exit 0
