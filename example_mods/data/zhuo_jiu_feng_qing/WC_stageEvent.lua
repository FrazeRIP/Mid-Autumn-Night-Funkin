
local secPerBeat=0

function onCreate()
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)

	makeLuaSprite('halfWhiteFrame', 'common/whiteFrame', 0, 0);
	setObjectCamera('halfWhiteFrame','camHUD')
	doTweenColor('halfWhiteFrameC','halfWhiteFrame','FFFFFF',.00001)
	setBlendMode('halfWhiteFrame', 'add')

	makeAnimatedLuaSprite('OldMovie','stages/pin_jiu_ge/OldMovie',  0 ,  0 )
	addAnimationByPrefix('OldMovie','OldMovie','OldMovie',12,true);
	setObjectCamera('OldMovie', 'camHUD') 
	setBlendMode('OldMovie','add')
	doTweenColor('halfWhiteFrameC','halfWhiteFrame','522700',.00001)
	doTweenColor('OldMovieC','OldMovie','4A4A4A',.00001)

	addLuaSprite('OldMovie', true)
	addLuaSprite('halfWhiteFrame')

	
	doTweenAlpha("halfWhiteFrameA","halfWhiteFrame",0,0.00001,'cubeOut')
	doTweenAlpha("OldMovieA","OldMovie",0,0.00001,'cubeOut')
end

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.y', 550)
	setProperty('camFollow.x', 300)
	setProperty('camFollowPos.y', 550)
	setProperty('camFollowPos.x', 300)

	setProperty('isCameraOnForcedPos',true)
	
end

function onBeatHit( ... )
	if curBeat == 12 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'quadOut')
	end
	
	if curBeat == 16 then
		setProperty('isCameraOnForcedPos',false)
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end


	if curBeat == 78 then
		doTweenZoom('camGameZ', 'camGame', .65, secPerBeat*4,'quadInOut')
	end
	
	if curBeat == 142 then
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*4,'quadInOut')
	end

	if curBeat == 144 then
		cameraFlash('camGame','FFFFFF',secPerBeat)
		doTweenAlpha("halfWhiteFrameA","halfWhiteFrame",1,0.0001)
		doTweenAlpha("OldMovieA","OldMovie",1,0.00001)
		doTweenZoom('camGameZ', 'camGame', .65, secPerBeat*32,'cubeIn')
	end

	if curBeat == 172 then
		doTweenAlpha("halfWhiteFrameA","halfWhiteFrame",0,secPerBeat*4)
		doTweenAlpha("OldMovieA","OldMovie",0,secPerBeat*4)
	end

	if curBeat == 176 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*2,'quadInOut')
	end

	if curBeat == 240 then
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*4)
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*8,'quadInOut')
		setProperty('isCameraOnForcedPos',true)
		setProperty('camFollow.y', 550)
		setProperty('camFollow.x', 300)
	end
end

function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .6, secPerBeat*16,'smoothStepIn')
	end

end
