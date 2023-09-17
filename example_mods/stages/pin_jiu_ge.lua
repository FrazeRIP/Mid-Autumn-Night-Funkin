
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1.65

local secPerBeat=0
	
local lightMax = .7

local lightMin = .2

function onCreate()
	makeLuaSprite('Layer0', 'stages/pin_jiu_ge/WhitecatLayer0', 0 +Xoffset, 0 + Yoffset)
	setScrollFactor('Layer0', 0.75, 0.75);
	scaleObject('Layer0', ScaleOffset, ScaleOffset);


	makeLuaSprite('Layer1', 'stages/pin_jiu_ge/WhitecatLayer1', 0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer1', ScaleOffset, ScaleOffset);
	makeLuaSprite('Layer2', 'stages/pin_jiu_ge/WhitecatLayer2',0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer2', ScaleOffset, ScaleOffset);
	makeLuaSprite('Layer3', 'stages/pin_jiu_ge/WhitecatLayer3',0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer3', ScaleOffset, ScaleOffset);
	doTweenAlpha("Layer3A", 'Layer3', 0,0.001)

	makeAnimatedLuaSprite('guest0','stages/pin_jiu_ge/WhitecatGuest/WhitecatGuest0', -850 , 230 )
	scaleObject('guest0', ScaleOffset-.4, ScaleOffset-.4);
	doTweenColor('guest0C', 'guest0', 'A4A5B5',0.0001)
	addAnimationByPrefix('guest0','idle','WhitecatGuest0',24,false);
	
	makeAnimatedLuaSprite('guest1','stages/pin_jiu_ge/WhitecatGuest/WhitecatGuest1', 700 ,  200 )	
	scaleObject('guest1', ScaleOffset-.4, ScaleOffset-.4);
	doTweenColor('guest1C', 'guest1', 'A4A5B5',0.0001)
	addAnimationByPrefix('guest1','idle','WhitecatGuest1',24,false);
	
	makeAnimatedLuaSprite('guest2','stages/pin_jiu_ge/WhitecatGuest/WhitecatGuest2',  -1050 ,  480   )
	addAnimationByPrefix('guest2','idle','WhitecatGuest2',24,false);
	scaleObject('guest2', ScaleOffset-1, ScaleOffset-1);
	setScrollFactor('guest2', 1.1, .7);
	--doTweenColor('guest2C', 'guest2', 'A4A5B5',0.0001)

	addLuaSprite('Layer0', false);
	addLuaSprite('Layer1', false);
	addLuaSprite('Layer2', false);

	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guest2', true);
	addLuaSprite('Layer3', false);
end

function onBeatHit()
	if curBeat % 2 == 0 then
	
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	end

	if curBeat % 8 == 0 then
		doTweenAlpha("Layer3A1", 'Layer3', lightMax,secPerBeat*4)
	end
end





function onCreatePost( ... )
	secPerBeat = 60/curBpm

	doTweenX('gfScaleX', 'gf.scale', .5, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .5, 0.0001)

	--doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	--doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', .6, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', .6, 0.0001)
end



function onTweenCompleted(tag)
	if tag == 'Layer3A1' then
		doTweenAlpha("Layer3A2", 'Layer3', lightMin,secPerBeat*4)
	end
end