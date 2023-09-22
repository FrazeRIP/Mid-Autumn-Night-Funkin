
local secPerBeat=0

function onCreate()
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
end

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.y', 500)
	setProperty('camFollow.x', 280)
	setProperty('camFollowPos.y', 500)
	setProperty('camFollowPos.x', 280)

	setProperty('isCameraOnForcedPos',true)

	
	makeLuaSprite('fog','mechanism/Rincy/fog', -800,0);
	setScrollFactor('fog', .5, .5);
	scaleObject('fog', 1.2, 1);
	addLuaSprite('fog', true);
	doTweenAlpha("fogA","fog",0, 0.0001)
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('bg','idle',true);
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
end


function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*32,'smoothStepIn')
	end
end

function onBeatHit( ... )
	if curBeat == 32 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		setProperty('isCameraOnForcedPos',false)
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'quadOut')
	end

	if curBeat == 64 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 96 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .7, secPerBeat*12)
	end

	if curBeat ==108 then
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*2,'cubeOut')
	end
	
	if curBeat == 110 then
		setProperty('camFollow.x', 380)
	end

	if curBeat == 112 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		setProperty('isCameraOnForcedPos',false)
	end
	
	if curBeat == 176 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 240 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 288 then
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .7, secPerBeat*12)
	end

	if curBeat == 300 then
		setProperty('isCameraOnForcedPos',false)
		doTweenZoom('camGameZ', 'camGame', .8, secPerBeat*2,'cubeOut')
	end
	
	if curBeat == 304 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*2,'cubeOut')
	end
	
	if curBeat == 368 then
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .7, secPerBeat*4)
	end

	if curBeat ==372 then
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*2,'cubeOut')
	end

	if curBeat == 376 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		setProperty('isCameraOnForcedPos',false)
	end
	
	if curBeat ==400 then
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
	end

	if curBeat ==404 then
		setProperty('isCameraOnForcedPos',false)
	end

	if curBeat ==438 then
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .65, secPerBeat*32,'smoothStepIn')
	    
	end

	if curBeat ==  442 then
		for i = 0,3 do
			noteTweenAlpha('NoteA'..i, i, 0, secPerBeat, 'cubeOut')
		end
	end

	if curBeat == 446 then
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*8,'quadOut')
	end
end