
local secPerBeat=0

local isFlying = false

function onCreate()
	setProperty("skipCountdown", true)
	doTweenAlpha("HUDAlpha","camHUD",0,0.00001)

	makeLuaSprite('solidB', '', -1000, -500);
	makeGraphic('solidB', '4000','2000', '000000')
	addLuaSprite('solidB')
	doTweenAlpha("solidBA","solidB",0.0,0.00001,'cubeOut')

	
	makeLuaSprite('solidF', '', -1000, -500);
	makeGraphic('solidF', '4000','2000', 'FFFFFF')
	addLuaSprite('solidF',true)
	doTweenAlpha("solidFA","solidF",0.0,0.00001,'cubeOut')
end

function onCreatePost()
	secPerBeat = 60/curBpm

	setProperty('camFollow.y', 420)
	setProperty('camFollow.x', 280)
	setProperty('camFollowPos.y', 420)
	setProperty('camFollowPos.x', 280)

	setProperty('isCameraOnForcedPos',true)

	
	makeLuaSprite('fog','mechanism/Rincy/fog', -800,0);
	setScrollFactor('fog', .5, .5);
	scaleObject('fog', 1.2, 1);
	addLuaSprite('fog', true);
	doTweenAlpha("fogA","fog",0, 0.0001)
end

function onUpdate( elapsed)
	secPerBeat = 60/curBpm
end


function onStepHit( ... )
	if curStep == 1 then
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*8,'smoothStepIn')
	end
end

function onBeatHit( ... )
	if curBeat == 6 then
		doTweenAlpha("HUDAlpha","camHUD",1,secPerBeat*2,'quadOut')
	end
	
	if curBeat == 8 then
		setProperty('isCameraOnForcedPos',false)
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 72 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	    for i = 0,3 do
			noteTweenAlpha('NoteA'..i, i, 0, secPerBeat*4, 'cubeOut')
		end
		secPerBeat = 60/curBpm
		setProperty('camFollow.y', 500)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .68, secPerBeat*32,'cubeOut')
		doTweenAlpha("solidBA","solidB",0.8, secPerBeat*32)

		
		doTweenAlpha("fogA","fog",0.8, secPerBeat*32,'cubeOut')
		doTweenX('fogX', 'fog', -500,secPerBeat*32)
	end

	if curBeat == 116 then
		setProperty('camFollow.x', 100)
		doTweenZoom('camGameZ', 'camGame', .8, secPerBeat*2,'cubeOut')
	end

	if curBeat == 118 then
	    for i = 0,3 do
			noteTweenAlpha('NoteA'..i, i, 1, secPerBeat*2, 'cubeOut')
		end
	end

	if curBeat == 119 then
		doTweenAlpha("solidFA","solidF",  1, secPerBeat*2, 'cubeOut')
	end

	if curBeat == 120 then
		isFlying = true
		doTweenAlpha("fogA","fog",0, secPerBeat*4)
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenAlpha("solidFA","solidF",0.0,0.00001,'cubeOut')
		doTweenAlpha("solidBA","solidB",0,0.0001,'cubeOut')
		setProperty('isCameraOnForcedPos',false)
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*4,'cubeOut')
		doTweenY('dadY1', 'dad', defaultOpponentX +50 , secPerBeat*4, 'cubeOut')
	end

	if curBeat == 152 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 184 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
	end

	if curBeat == 204 then
		setProperty('camFollow.y', 420)
		setProperty('camFollow.x', 280)
		setProperty('isCameraOnForcedPos',true)
		doTweenZoom('camGameZ', 'camGame', .68, secPerBeat*32,'cubeOut')
	end

	-------------------------------
	--White Out
	if curBeat == 220 then
		doTweenX('fogX', 'fog', -800,0.0001)
		doTweenX('fogX1', 'fog', -500, secPerBeat*32)
		doTweenAlpha("fogA","fog",.8,  secPerBeat*8)
		makeGraphic('solidB', '4000','2000', 'FFFFFF')
	end

	if curBeat == 224 then
		doTweenAlpha("solidBA","solidB", 1,	secPerBeat*6, 'quadIn')
		doTweenAlpha("solidFA","solidF",  1, secPerBeat*6, 'quadIn')
		doTweenColor("bfC","boyfriend",  '000000', secPerBeat*6, 'quadIn')
		doTweenColor("dadC","dad",  '000000', secPerBeat*6, 'quadIn')
	end


	if curBeat == 228 then
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*2,'quadOut')
	end

	if curBeat == 230 then
	---------------------------------------------------
	--UI
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG2.alpha', 0)

		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)

		setProperty("timeBarBG.visible",false)
		setProperty("timeBar.visible",false)
		setProperty("timeTxt.visible",false)

		setProperty('scoreTxt.alpha', 0)
	---------------------------------------------------
		setProperty('camFollow.y', 350)
	end

	if curBeat == 232 then
	
		doTweenAlpha("HUDAlpha","camHUD",1,0.0001,'quadOut')
	    for i = 4,7 do
			noteTweenAlpha('NoteA'..i, i, 0, 0.0001, 'cubeOut')
		end

		doTweenAlpha("fogA","fog",0,  0.0001)
		doTweenAlpha("solidFA","solidF",  0, secPerBeat*2, 'cubeOut')
		doTweenAlpha("guest3a","guest3",0, 0.001)
		doTweenAlpha("bg6A","bg6",0, 0.001)
		doTweenAlpha("gfA","gf",0, 0.001)
	end
	

	if curBeat == 262 then
	    for i = 4,7 do
			noteTweenAlpha('NoteA'..i, i, 1, secPerBeat*1.5+i*0.1, 'cubeOut')
		end
	end

	if curBeat == 296 then
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		setProperty('camFollow.y', 420)
		doTweenColor("dadC","dad",  'FFFFFF', secPerBeat*32, 'quadIn')
		doTweenColor("bfC","boyfriend",  'FFFFFF', secPerBeat*32, 'quadIn')
		doTweenAlpha("guest3a","guest3",1, secPerBeat*32, 'quadIn')
		doTweenAlpha("bg6A","bg6",1,secPerBeat*32, 'quadIn')
		doTweenAlpha("gfA","gf",1, secPerBeat*32, 'quadIn')
		doTweenAlpha("fogA","fog",.7,  secPerBeat*32, 'quadOut')
		doTweenAlpha("solidBA","solidB", 0,	secPerBeat*32, 'quadIn')
		doTweenZoom('camGameZ', 'camGame', .75, secPerBeat*32,'quadInOut')
	end

	if curBeat == 328 then
	---------------------------------------------------
	--UI
		setProperty('healthBar.alpha', 1)
		setProperty('healthBarBG2.alpha', 1)

		setProperty('iconP1.alpha',1)
		setProperty('iconP2.alpha', 1)

		setProperty("timeBarBG.visible",true)
		setProperty("timeBar.visible",true)
		setProperty("timeTxt.visible",true)

		setProperty('scoreTxt.alpha', 1)
	---------------------------------------------------
		setProperty('isCameraOnForcedPos',false)
	---------------------------------------------------
		cameraFlash('camGame','FFFFFF',secPerBeat*2)
		doTweenAlpha("fogA","fog",0, 0.00001, 'quadIn')
	end

	-------------------------------
	if curBeat == 456 then
		cameraFlash('camGame','FFFFFF',secPerBeat*4)
		doTweenAlpha("HUDAlpha","camHUD",0,secPerBeat*8)
		doTweenZoom('camGameZ', 'camGame', .68, secPerBeat*16,'quadInOut')
		setProperty('isCameraOnForcedPos',true)
		setProperty('camFollow.y', 420)
		setProperty('camFollow.x', 300)
	end
end

function onTweenCompleted( tag )

	if isFlying then

	if tag == 'dadY1' then
		doTweenY('dadY2', 'dad', defaultOpponentX+50, secPerBeat*4, 'cubeOut')
	end

	if tag == 'dadY2' then
		doTweenY('dadY1', 'dad', defaultOpponentX +100 , secPerBeat*4, 'cubeOut')
	end

	end
end



