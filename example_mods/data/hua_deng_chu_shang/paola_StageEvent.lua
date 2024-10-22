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
	setProperty('cameraSpeed',.6)

	makePexParticle("paola_glow",-1200,1200,2,"camGame")
	secPerBeat = 60/curBpm
	
end


function onBeatHit( ... )

	if curBeat == 4 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end
	
	if curBeat == 5 then
	setProperty('cameraSpeed',1)
	setProperty('isCameraOnForcedPos',false)
	end

	if curBeat == 18 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'cubeOut')
	end

	--------------------------------------
	--First Zoom
	if curBeat == 52 then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4, 'quadOut')
		triggerEvent('Manage Cam Dir Position Lock', '0,400', '350,400')
	end

	if curBeat == 84 then
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4, 'lienar')
		triggerEvent('Manage Cam Dir Position Lock', '200,400', '200,400')
	end

	if curBeat == 88 then
		doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*1.5, 'quadOut')
		triggerEvent('Manage Cam Dir Position Lock', '', '')
		playParticle("paola_glow",false,0.15)
		cameraFlash('camGame','FFFFFF',secPerBeat)
	end
	--------------------------------------
	--2nd Zoom
	if curBeat == 120 then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4, 'quadOut')
		triggerEvent('Manage Cam Dir Position Lock', '0,400', '350,400')
	end

	if curBeat == 152 then
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4, 'lienar')
		triggerEvent('Manage Cam Dir Position Lock', '200,400', '200,400')
	end

	if curBeat == 156 then
		doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*1.5, 'quadOut')
		triggerEvent('Manage Cam Dir Position Lock', '', '')
		playParticle("paola_glow",false,0.08)
		cameraFlash('camGame','FFFFFF',secPerBeat)
	end
	--------------------------------------
	--Final
	if curBeat == 188 then
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*4)
		setProperty('isCameraOnForcedPos',true)
		setProperty('camFollow.x', 300)
		setProperty('cameraSpeed',.35)
		doTweenY('camFollowY', 'camFollow', -2800, 1,'quintIn')
	end
end

function onStepHit( ... )
	if curStep == 1 then
		doTweenY('camFollowY', 'camFollow', 250, 1,'quintIn')
	end
end
