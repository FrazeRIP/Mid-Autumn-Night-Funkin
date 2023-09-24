
local secPerBeat=0

function onCreate()
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
	
	makeLuaSprite('solidB', '', -1000, -500);
	makeGraphic('solidB', '4000','2000', 'FFFFFF')
	makeGraphic('solidB', '4000','2000', '000000')
	addLuaSprite('solidB')
	doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
end

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.x', 1350)
	setProperty('camFollowPos.x', 1350)
	setProperty('camFollow.y', 750)
	setProperty('camFollowPos.y', 750)

	setProperty('isCameraOnForcedPos',true)

end
function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*8,'smoothStepIn')
	end
end

function onBeatHit( ... )

	if curBeat == 6 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'quadOut')
	end
	
	if curBeat == 8 then
		setProperty('isCameraOnForcedPos',false)
	end

	if curBeat == 56 then
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*4,'cubeOut')
	end
	

	if curBeat == 88 then
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4,'cubeOut')
	end

	if curBeat == 152 then
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*4,'cubeOut')
		doTweenAlpha("solidBA","solidB",0.7,secPerBeat*4,'quadOut')
	end

	if curBeat == 156 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .7, secPerBeat*64)
	end

	if curBeat == 188 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 224 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenAlpha("solidBA","solidB",0,secPerBeat*4,'quadOut')
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4,'cubeOut')
	end


	if curBeat == 256 then
		local amount = '1350,750'
		triggerEvent('Manage Cam Dir Position Lock', amount, amount)
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*64,'cubeOut')
	end

	if curBeat == 320 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*8)
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*8)
	end
end