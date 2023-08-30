local secPerBeat=0


function onCreate()
	setProperty("skipCountdown", true)
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)

end

function onCreatePost()
	setProperty('camFollow.y', -2800)
	setProperty('camFollow.x', 300)
	setProperty('camFollowPos.y', -2800)
	setProperty('camFollowPos.x', 300)
	setProperty('isCameraOnForcedPos',true)
	setProperty('cameraSpeed',.25)
	setProperty('camZooming',false)

	
	secPerBeat = 60/curBpm
end


function onBeatHit( ... )
	if curBeat == 4 then
		doTweenY('camFollowY', 'camFollow', 200, .5,'cubeIn')
		--setProperty('camFollow.y', 200)
	end

	if curBeat == 18 then
	doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'cubeOut')
	end

	if curBeat == 20 then
	setProperty('cameraSpeed',1)
	setProperty('isCameraOnForcedPos',false)
	end

end