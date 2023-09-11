
local xOffset = -750
local yOffset = -170
local scale = .65

local lightColor = 'FFFFFF'
local defaultColor = 'D9B7A7'
local darkColor = 'B08F7F'

local bgSprites = {}

local secPerBeat

function onCreate()
	makeLuaSprite('sky', 'stages/lord_rabbit/RopryLayer0',xOffset+ 0, yOffset+0);
	setScrollFactor('sky', 0.8, 0.8);
	scaleObject('sky', scale, scale);

	makeLuaSprite('bg', 'stages/lord_rabbit/RopryLayer1', xOffset+ 0, yOffset+0);
	scaleObject('bg', scale, scale);

	makeLuaSprite('window', 'stages/lord_rabbit/RopryLayer2', xOffset+ 0, yOffset+0);
	scaleObject('window', scale, scale);

	makeAnimatedLuaSprite('guest0','stages/lord_rabbit/RopryGuest/RopryGuest0',xOffset+ 150, yOffset+250);
	addAnimationByPrefix('guest0','idle','RopryGuest0',24,false);
	scaleObject('guest0', scale, scale);

	makeAnimatedLuaSprite('guest1','stages/lord_rabbit/RopryGuest/RopryGuest1',xOffset+ 1250, yOffset+250);
	addAnimationByPrefix('guest1','idle','RopryGuest1',24,false);
	scaleObject('guest1', scale, scale);

	makeAnimatedLuaSprite('guest2','stages/lord_rabbit/RopryGuest/RopryGuest2',xOffset+ 580, yOffset+185);
	addAnimationByPrefix('guest2','idle','RopryGuest2',24,false);
	scaleObject('guest2', scale, scale);
	
	makeAnimatedLuaSprite('guest3','stages/lord_rabbit/RopryGuest/RopryGuest3', xOffset+950, yOffset+185);
	addAnimationByPrefix('guest3','idle','Ropry_Guest3',24,false);
	scaleObject('guest3', scale, scale);

	makeLuaSprite('rabbit', 'stages/lord_rabbit/RopryLayer3', xOffset- 237, yOffset+0);
	scaleObject('rabbit', scale, scale);

	makeAnimatedLuaSprite('lantern','stages/lord_rabbit/RopryLayer4', xOffset-130, yOffset+0);
	addAnimationByPrefix('lantern','idle','RopryLayer4',24,true);
	objectPlayAnimation('lantern','idle',true);
	scaleObject('lantern', scale, scale);

	makeLuaSprite('light', 'stages/lord_rabbit/RopryLayer5', xOffset+ 0, yOffset+0);
	scaleObject('light', scale, scale);

	makeLuaSprite('curtain', 'stages/lord_rabbit/RopryLayer6', xOffset+ 0, yOffset+0);
	scaleObject('curtain', scale, scale);

	makeAnimatedLuaSprite('guest4','stages/lord_rabbit/RopryGuest/RopryGuest4',  xOffset-100, yOffset+600);
	addAnimationByPrefix('guest4','idle','Ropry_Guest4',24,false);
	setScrollFactor('guest4', 1.2, 0.5);
	scaleObject('guest4', scale, scale);

	addLuaSprite('sky', false);
	table.insert(bgSprites, 'sky')

	addLuaSprite('bg', false);
	table.insert(bgSprites, 'bg')

	addLuaSprite('window', false);
	table.insert(bgSprites,'window')

	addLuaSprite('guest0', false);
	table.insert(bgSprites,'guest0')

	addLuaSprite('guest1', false);
	table.insert(bgSprites,'guest1')

	addLuaSprite('guest2', false);
	table.insert(bgSprites,'guest2')

	addLuaSprite('guest3', false);
	table.insert(bgSprites,'guest3')

	addLuaSprite('rabbit', false);
	table.insert(bgSprites,'rabbit')
	
	addLuaSprite('lantern', true);
	table.insert(bgSprites,'lantern')


	addLuaSprite('light', true);
	
	makeLuaSprite('blackGame', '', -1000, -500)
	makeGraphic('blackGame', 2300, 2000, '000000')
	addLuaSprite('blackGame', true);
	doTweenAlpha("blackA", 'blackGame', 0.95,0.0001)

	addLuaSprite('curtain', true);
	addLuaSprite('guest4', true);

	
	changeBGColor(defaultColor,0.001)
end
 
function onBeatHit()

	if curBeat == 112 then
		changeBGColor(darkColor,secPerBeat*16)
	end

	if curBeat == 144 then
		changeBGColor(lightColor,.25)
	end

	if curBeat == 208 then
		changeBGColor(defaultColor,secPerBeat*16)
	end

	---2nd
	if curBeat == 336 then
		changeBGColor(darkColor,secPerBeat*16)
	end
	if curBeat == 368 then
		changeBGColor(lightColor,.25)
	end
	
	if curBeat == 432 then
		changeBGColor(defaultColor,secPerBeat*16)
	end

	-- triggered 4 times per section
	if curBeat % 2 == 0 then

	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
	objectPlayAnimation('guest4','idle',true);

	end
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .42, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .42, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', .6, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .6, 0.0001)

	
	doTweenX('bfScaleX', 'boyfriend.scale', .5, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', .5, 0.0001)
	
	secPerBeat = 60/curBpm
end


function changeBGColor(color,time)
		for key,value in pairs(bgSprites) do 
			doTweenColor(value..'C1', value, color,time,'cubeOut')
		end
end
