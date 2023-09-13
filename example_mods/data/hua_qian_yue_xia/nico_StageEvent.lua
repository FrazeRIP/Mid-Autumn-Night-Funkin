local secPerBeat=0

local isCamSwing = false

function onCreate()
	--setProperty("skipCountdown", true)
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
end

function onCreatePost()
	secPerBeat = 60/curBpm
	
	setProperty('camFollow.y', 650)
	setProperty('camFollow.x', 250)
	setProperty('camFollowPos.y', 650)
	setProperty('camFollowPos.x', 250)
	doTweenZoom('camGameZ', 'camGame', .7, .0001, 'quadOut')
	setProperty('isCameraOnForcedPos',true)

end


function onBeatHit( ... )

	if curBeat == 14 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'cubeOut')
	end

	if curBeat == 16 then
		setProperty('isCameraOnForcedPos',false)
	end

	--------------------------------------
	--First Zoom
	--if curBeat == 52 then
	--	doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4, 'quadOut')
	--	triggerEvent('Manage Cam Dir Position Lock', '0,400', '350,400')
	--end

	--if curBeat == 84 then
	--	doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4, 'lienar')
	----	triggerEvent('Manage Cam Dir Position Lock', '200,400', '200,400')
	--end

	--if curBeat == 88 then
	--	doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*1.5, 'quadOut')
	--	triggerEvent('Manage Cam Dir Position Lock', '', '')
	--	cameraFlash('camGame','FFFFFF',secPerBeat)
	--end

	--1st climax-----------------------------------------
	if curBeat == 96 then
		playParticle("nico_petal",false,0.3)
	end

	if curBeat == 160 then
		doTweenZoom('camGameZ', 'camGame', .85, secPerBeat*32)
		setParticleAcc('nico_petal','1.5','1.5')
		playParticle("nico_petal",false,0.2)
	end

	if curBeat == 224 then
		isCamSwing = true
		setParticleAcc('nico_petal','6','6')
		playParticle("nico_petal",false,0.1)
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*4, 'quadOut')
	end

	if curBeat == 287 then
		setParticleAcc('nico_petal','.4','.4')
	end

	if curBeat == 288 then
		isCamSwing = false
		
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		playParticle("nico_petal",false,0.3)
		setProperty('isCameraOnForcedPos',true)
		setProperty('camFollow.y', 650)
		setProperty('camFollow.x', 250)
		doTweenZoom('camGameZ', 'camGame', .7, secPerBeat*32)
		doTweenAlpha("HUDAlpha","camHUD",0, secPerBeat*32, 'cubeOut')
	end
	----------------------------------------

	
	if isCamSwing and curBeat %2 == 0 then
		doTweenAngle('camHUDA1', 'camHUD','.8', 0.0001, 'cubeIn')
	
	elseif isCamSwing and curBeat  % 2 == 1 then
		doTweenAngle('camHUDA1', 'camHUD','-.8', 0.0001)
	end

end

function onStepHit( ... )
	if curStep == 1 then
		playParticle("nico_petal",false,0.4)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*16, 'quadInOut')
	end

end


function onTweenCompleted(tag)
	if tag == 'camHUDA1'then
		doTweenAngle('camHUDA2', 'camHUD','0',secPerBeat*1)
	end
end