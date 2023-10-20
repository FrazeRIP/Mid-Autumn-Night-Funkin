local secPerBeat

function onCreate( ... )
	setProperty("antialias",false)
	setProperty("isPixelStage",true)
end


function onCreatePost()
	secPerBeat = 60/curBpm

	--setProperty('camFollow.y', 500)
	--setProperty('camFollow.x', 280)
	--setProperty('camFollowPos.y', 500)
	--setProperty('camFollowPos.x', 280)

	--setProperty('isCameraOnForcedPos',true)
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
end


function onBeatHit( ... )
	if curBeat == 30 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'cubeOut')
	end
end


