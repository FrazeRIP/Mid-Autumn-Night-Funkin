
local secPerBeat=0

function onCreatePost( ... )
	doTweenX('paolaSX', 'dad.scale', .85, .00001)
	doTweenY('paolaSY', 'dad.scale', .85, .00001)
	doTweenX('bfSX', 'boyfriend.scale', .65, .00001)
	doTweenY('bfSY', 'boyfriend.scale', .65,.00001)
	doTweenX('gfSX', 'gf.scale', .47, .00001)
	doTweenY('gfSY', 'gf.scale', .47, .00001)
	
	
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)

	secPerBeat = 60/curBpm

	setProperty('camFollow.x', 950)
	setProperty('camFollow.y', 550)
	setProperty('camFollowPos.x', 950)
	setProperty('camFollowPos.y', 550)
	
	setProperty('isCameraOnForcedPos',true)
end


function onBeatHit( ... )
	if curBeat == 14 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'quadOut')
		setProperty('isCameraOnForcedPos',false)
	end

	if curBeat == 28 then
		setProperty('camFollow.x', 950)
		setProperty('camFollow.y', 620)
		setProperty('isCameraOnForcedPos',true)
	end

	if curBeat == 32 then
		cameraFlash('camGame','FFFFFF',secPerBeat*4)
		setProperty('isCameraOnForcedPos',false)
	end

	if curBeat == 128 then
		setProperty('camFollow.x', 950)
		setProperty('camFollow.y', 620)
		setProperty('isCameraOnForcedPos',true)
	end

	if curBeat == 144 then
		setProperty('isCameraOnForcedPos',false)
	end
	
	if curBeat == 160 then
		setProperty('camFollow.x', 950)
		setProperty('camFollow.y', 620)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .85, secPerBeat*4,'smoothStepIn')
	end

	if curBeat == 164 then
		setProperty('isCameraOnForcedPos',false)
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .8, secPerBeat*2,'cubeOut')
	end

	if curBeat == 196 then
		cameraFlash('camGame','FFFFFF',secPerBeat*4)
	end
end



function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .8, secPerBeat*16,'smoothStepIn')
	end
	end
