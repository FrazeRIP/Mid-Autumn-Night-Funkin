


function onBeatHit( ... )
	if curBeat == 450 then
		setProperty("boyfriend.heyTimer",9999)
		setProperty("dad.heyTimer",9999)
		triggerEvent("Play Animation", 'hey', 'bf')
		triggerEvent("Play Animation", 'hey', 'dad')
	end
end