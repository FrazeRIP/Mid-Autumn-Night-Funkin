
local secPerBeat=0

function onCreate()
	--doTweenAlpha("HUDAlpha","camHUD",0,0.00001)
end

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.x', 200)
	setProperty('camFollow.y', 150)
	setProperty('camFollowPos.x', 200)
	setProperty('camFollowPos.y', 150)

	--setProperty('isCameraOnForcedPos',true)

	doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
end

function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .45, secPerBeat*16,'smoothStepIn')
	end
	-------------------------------------
	if curStep == 720 then
		doTweenZoom('camGameZ', 'camGame', .46, .2,'cubeOut')
	end
	if curStep == 723 then
		doTweenZoom('camGameZ', 'camGame', .47, .2,'cubeOut')
	end
	if curStep == 726 then
		doTweenZoom('camGameZ', 'camGame', .48, .2,'cubeOut')
	end
	if curStep == 729 then
		doTweenZoom('camGameZ', 'camGame', .49, .2,'cubeOut')
	end
	if curStep == 732 then
		doTweenZoom('camGameZ', 'camGame', .50, .2,'cubeOut')
	end
	if curStep == 734 then
		doTweenZoom('camGameZ', 'camGame', .51, .2,'cubeOut')
	end
	-------------------------------------
	if curStep == 912 then
		doTweenZoom('camGameZ', 'camGame', .46, .2,'cubeOut')
	end
	if curStep == 915 then
		doTweenZoom('camGameZ', 'camGame', .47, .2,'cubeOut')
	end
	if curStep == 918 then
		doTweenZoom('camGameZ', 'camGame', .48, .2,'cubeOut')
	end
	if curStep == 921 then
		doTweenZoom('camGameZ', 'camGame', .49, .2,'cubeOut')
	end
	if curStep == 924 then
		doTweenZoom('camGameZ', 'camGame', .50, .2,'cubeOut')
	end
	if curStep == 925 then
		doTweenZoom('camGameZ', 'camGame', .51, .2,'cubeOut')
	end
	-------------------------------------
	if curStep == 976 then
		doTweenAlpha("solidBA","solidB",0.3,secPerBeat*4,'cubeOut')
		doTweenZoom('camGameZ', 'camGame', .46, .2,'cubeOut')
	end
	if curStep == 979 then
		doTweenZoom('camGameZ', 'camGame', .47, .2,'cubeOut')
	end
	if curStep == 982 then
		doTweenZoom('camGameZ', 'camGame', .48, .2,'cubeOut')
	end
	if curStep == 985 then
		doTweenZoom('camGameZ', 'camGame', .49, .2,'cubeOut')
	end
	if curStep == 988 then
		doTweenZoom('camGameZ', 'camGame', .50, .2,'cubeOut')
	end
	if curStep == 990 then
		doTweenZoom('camGameZ', 'camGame', .51, .2,'cubeOut')
	end
end

function onBeatHit( ... )
	if curBeat == 8 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*4,'quadOut')
		setProperty('isCameraOnForcedPos',false)
	end

	if curBeat == 28 then
		cameraReset(true)
	end

	if curBeat == 52 then
		cameraToIS(true)
	end

	if curBeat ==76 then
		cameraToCenter(true)
	end

	if curBeat == 84 then
		cameraToGA(true)
	end

	if curBeat == 108 then
		cameraToCenter(true)
	end

	if curBeat == 116 then
		doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*8)
	end

	if curBeat == 120 then
		cameraReset(true)
	end

	if curBeat == 128 then
		cameraToIS(true)
	end

	if curBeat == 134 then
		cameraToZella(true)
	end

	if curBeat == 148 then
		doTweenZoom('camGameZ', 'camGame', .55, secPerBeat*4,'cubeOut')
	end

	if curBeat == 152 then
		doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
		cameraToGA(true)
	end

	if curBeat == 184 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		cameraToCenter(true)
		doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
	end

	if curBeat == 196 then
		cameraReset(true)
	end

	if curBeat == 200 then
		cameraToCenter(true)
	end

	if curBeat == 212 then
		cameraReset(true)
	end

	if curBeat ==216 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
		triggerEvent('Manage Cam Dir Position Lock', '350,250', '350,250')
	end

	if curBeat ==232 then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
		triggerEvent('Manage Cam Dir Position Lock', '350,250', '350,250')
		doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
	end

	if curBeat == 248 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*16,'cubeOut')
		setProperty('isCameraOnForcedPos',true)
		doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')
	end

	if curBeat ==284 then
		setProperty('isCameraOnForcedPos',false)
		cameraToGA(true)
	end

	if curBeat == 300 then
		cameraToZella(true)
	end

	if curBeat ==308 then
		cameraToCenter(true)
	end

	if curBeat ==316 then
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .4, secPerBeat*16,'cubeOut')
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*8)
	end
end


function cameraReset( zoom )
	if zoom then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
	end

	triggerEvent('Manage Cam Dir Position Lock', '', '')
end

function cameraToIS( zoom )
	if zoom then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
	end

	triggerEvent('Manage Cam Dir Position Lock', '-250,250', '450,250')
end

function cameraToGA( zoom )
	if zoom then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
	end

	triggerEvent('Manage Cam Dir Position Lock', '50,250', '450,250')
end

function cameraToZella(zoom )
	if zoom then
		doTweenZoom('camGameZ', 'camGame', .5, secPerBeat*4,'cubeOut')
	end

	triggerEvent('Manage Cam Dir Position Lock', '-150,250', '450,250')
end

function cameraToCenter(zoom)
	if zoom then
		doTweenZoom('camGameZ', 'camGame', .45, secPerBeat*4,'cubeOut')
	end

	triggerEvent('Manage Cam Dir Position Lock', '200,150', '200,150')
end