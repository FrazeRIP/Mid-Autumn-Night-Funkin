function onCreate()
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
end

local secPerBeat=0

local isCamSwing = false

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.y', 400)
	setProperty('camFollow.x', 200)
	setProperty('camFollowPos.y', 400)
	setProperty('camFollowPos.x', 200)
	doTweenZoom('camGameZ', 'camGame', .7, .0001, 'quadOut')

	setProperty('isCameraOnForcedPos',true)

end

function onBeatHit( ... )
	if curBeat == 14 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2)
		setProperty('isCameraOnForcedPos',false)
	end
	
	if curBeat == 112 then
		doTweenZoom('camGameZ', 'camGame', .9, secPerBeat*32)
	end
	--1st climax-----------------------------------------
	if curBeat == 144 then
		isCamSwing = true
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*4, 'quadOut')
	end

	if curBeat == 176 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 208 then
		isCamSwing = false
	end
	----------------------------------------
	
	--2st climax-----------------------------------------
	if curBeat == 336 then
		doTweenZoom('camGameZ', 'camGame', .9, secPerBeat*32)
	end
	if curBeat == 368 then
		isCamSwing = true
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*4, 'quadOut')
	end
	if curBeat == 400 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end
	----------------------------------------

	if curBeat == 432 then
		isCamSwing = false
		doTweenAlpha("HUDAlphaAAA","camHUD",0,secPerBeat*8,'quadOut')
		setProperty('isCameraOnForcedPos',true)
		setProperty('camFollow.y', 400)
		setProperty('camFollow.x', 200)
		changeBGColor(defaultColor,secPerBeat*16)
	end


	if curBeat == 450 then
		setProperty("boyfriend.heyTimer",9999)
		setProperty("dad.heyTimer",9999)
		triggerEvent("Play Animation", 'hey', 'bf')
		triggerEvent("Play Animation", 'hey', 'dad')
	end
	
	if curBeat == 460 then
		doTweenAlpha("blackA", 'blackGame', 0.95,secPerBeat*8,'quadOut')
	end
	
	if isCamSwing and curBeat %2 == 0 then
		doTweenAngle('camHUDA1', 'camHUD','.8', 0.0001, 'cubeIn')
	
	elseif isCamSwing and curBeat  % 2 == 1 then
		doTweenAngle('camHUDA1', 'camHUD','-.8', 0.0001)
	end
end


function onStepHit( ... )
	if curStep == 2 then
		doTweenAlpha("blackA", 'blackGame', 0.9,4)
		doTweenZoom('camGameZ', 'camGame', .75, 4,'smoothStepInOut')
	end

	if curStep == 38 then
		doTweenAlpha("blackA", 'blackGame', 0,0.25)
	end
end


function onTweenCompleted(tag)
	if tag == 'camHUDA1'then
		doTweenAngle('camHUDA2', 'camHUD','0',secPerBeat*1)
	end
end