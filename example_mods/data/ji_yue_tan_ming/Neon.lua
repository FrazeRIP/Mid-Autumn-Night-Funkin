
local secPerBeat=0

local colors = {'FF0000','00FF00','0000FF','FFFC00'}

local isBlinking = false

local isUIBlinking = false

function onCreatePost( ... )
	makeLuaSprite('whiteFrame', 'common/whiteFrame', 0, 0);
	setObjectCamera('whiteFrame','camHUD')
	doTweenColor('whiteFrameC','whiteFrame','FFFFFF',.00001)
	setBlendMode('whiteFrame', 'add')
	addLuaSprite('whiteFrame')
	doTweenAlpha("whiteFrameA","whiteFrame",0,0.00001,'cubeOut')
	
	makeLuaSprite('icecream', 'mechanism/Rincy/icecream', 115, 75);
	setObjectCamera('icecream','camOther')
	addLuaSprite('icecream')
	
	makeLuaSprite('iscream', 'mechanism/Rincy/iscream', 115, 75);
	setObjectCamera('iscream','camOther')
	addLuaSprite('iscream')

	doTweenX('icecreamSX', 'icecream.scale',.5,0.0001)
	doTweenY('icecreamSY', 'icecream.scale',.5,0.0001)
	doTweenX('iscreamSX', 'iscream.scale',.5,0.0001)
	doTweenY('iscreamSY', 'iscream.scale',.5,0.0001)
	doTweenAlpha("icecreamA","icecream",0,0.00001,'cubeOut')
	doTweenAlpha("iscreamA","iscream",0,0.00001,'cubeOut')
end


function onBeatHit( ... )

	if curBeat == 120 then
		isBlinking = true
	end

	if curBeat == 328 then
		isUIBlinking = true
	end

	if curBeat == 456 then
		isBlinking = false
		isUIBlinking = false
	end

	if isBlinking then
		doTweenColor("whiteFade2c","whiteFade2",  colors[(curBeat%4)+1], 0.0001)
		doTweenAlpha("whiteFade2A1","whiteFade2",0.7, 0.0001)
		doTweenAlpha("whiteFade2A2","whiteFade2",0, secPerBeat,'quadOut')
	end

	if isUIBlinking then
		doTweenColor("whiteFrameC","whiteFrame",  colors[(curBeat%4)+1], 0.00001)
		doTweenAlpha("whiteFrameAD1","whiteFrame",0.3,0.0001)
		doTweenAlpha("whiteFrameAD2","whiteFrame",0,secPerBeat,'quadOut')
	end


	if curBeat == 326 then
		doTweenX('icecreamSX', 'icecream.scale',.9,secPerBeat,'cubeOut')
		doTweenY('icecreamSY', 'icecream.scale',.9,secPerBeat,'cubeOut')
		doTweenX('iscreamSX', 'iscream.scale',.9,secPerBeat,'cubeOut')
		doTweenY('iscreamSY', 'iscream.scale',.9,secPerBeat,'cubeOut')
	end

	if curBeat == 327 then
		doTweenX('icecreamSX', 'icecream.scale',1,secPerBeat*3,'cubeOut')
		doTweenY('icecreamSY', 'icecream.scale',1,secPerBeat*3,'cubeOut')
		doTweenX('iscreamSX', 'iscream.scale',1,secPerBeat*3,'cubeOut')
		doTweenY('iscreamSY', 'iscream.scale',1,secPerBeat*3,'cubeOut')
	end
end

function onUpdate( elapsed)
	secPerBeat = 60/curBpm
end

function onStepHit( ... )
	if curStep == 864
	or curStep == 868
	or curStep == 872
	or curStep == 876
	or curStep == 878+2
	or curStep == 880+2
	or curStep == 882+2
	or curStep == 884+2
	or curStep == 885+2
	or curStep == 886+2
	or curStep == 887+2
	or curStep == 888+2
	or curStep == 889+2
	or curStep == 890+2
	or curStep == 891+2
	or curStep == 892+2
	then
		triggerEvent('GameHop', '0.02', '')
		doTweenColor("whiteFrameC","whiteFrame",  colors[(curBeat%4)+1], 0.00001)
		doTweenAlpha("whiteFrameA1","whiteFrame",0.6,0.0001)
		doTweenAlpha("whiteFrameA2","whiteFrame",0,secPerBeat,'quadOut')
	end


	if curStep == 1304 then
		doTweenAlpha("icecreamA","icecream",0,0.00001,'cubeOut')
		doTweenAlpha("iscreamA","iscream",1,0.00001,'cubeOut')
	end

	if curStep == 1305 then
		doTweenAlpha("icecreamA","icecream",0,0.00001,'cubeOut')
		doTweenAlpha("iscreamA","iscream",0,0.00001,'cubeOut')
	end

	if curStep == 1306 then
		doTweenAlpha("icecreamA","icecream",1,0.00001,'cubeOut')
		doTweenAlpha("iscreamA","iscream",0,0.00001,'cubeOut')
	end

	if curStep == 1307 then
		doTweenAlpha("icecreamA","icecream",0,0.00001,'cubeOut')
		doTweenAlpha("iscreamA","iscream",0,0.00001,'cubeOut')
	end
	
	if curStep == 1308 then
		doTweenAlpha("icecreamA","icecream",0,0.00001,'cubeOut')
		doTweenAlpha("iscreamA","iscream",1,0.00001,'cubeOut')
		doTweenAlpha("iscreamA2","iscream",0,secPerBeat*4,'cubeOut')
	end

end

