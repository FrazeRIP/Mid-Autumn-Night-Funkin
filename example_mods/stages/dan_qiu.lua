
local xOffset = 0
local yOffset = 0
local scale = 1

local secPerBeat

function onCreate()
	makeLuaSprite('sky', 'stages/dan_qiu/sky',xOffset+ 0, yOffset-900);
	setScrollFactor('sky', 0.6, 0.6);
	scaleObject('sky', scale, scale);

	makeLuaSprite('moon', 'stages/dan_qiu/moon', xOffset+ 0, yOffset-900);
	setScrollFactor('moon', 0.6, 0.6);
	scaleObject('moon', scale, scale);

	makeLuaSprite('mountain', 'stages/dan_qiu/mountain', xOffset+ 0, yOffset+0);
	setScrollFactor('moon', 0.8, 0.8);
	scaleObject('mountain', scale, scale);

	makeLuaSprite('floor', 'stages/dan_qiu/floor', xOffset+ 0, yOffset+0);
	scaleObject('floor', scale, scale);

	makeAnimatedLuaSprite('lantern0','stages/dan_qiu/lantern', xOffset+175, yOffset+320);
	addAnimationByPrefix('lantern0','idle','deng0',24,true);
	objectPlayAnimation('lantern0','idle',true);
	scaleObject('lantern0', scale, scale);

	makeAnimatedLuaSprite('lantern1','stages/dan_qiu/lantern', xOffset+355, yOffset+320);
	addAnimationByPrefix('lantern1','idle','deng0',24,true);
	objectPlayAnimation('lantern1','idle',true);
	scaleObject('lantern1', scale, scale);

	makeAnimatedLuaSprite('lantern2','stages/dan_qiu/lantern', xOffset+520, yOffset+320);
	addAnimationByPrefix('lantern2','idle','deng0',24,true);
	objectPlayAnimation('lantern2','idle',true);
	setProperty('lantern2.flipX',true);
	scaleObject('lantern2', scale, scale);

	makeAnimatedLuaSprite('lantern3','stages/dan_qiu/lantern', xOffset+700, yOffset+320);
	addAnimationByPrefix('lantern3','idle','deng0',24,true);
	objectPlayAnimation('lantern3','idle',true);
	setProperty('lantern3.flipX',true);
	scaleObject('lantern3', scale, scale);

	makeAnimatedLuaSprite('lantern4','stages/dan_qiu/lantern', xOffset-300, yOffset+80);
	addAnimationByPrefix('lantern4','idle','deng2',24,true);
	objectPlayAnimation('lantern4','idle',true);
	scaleObject('lantern4', scale, scale);

	makeAnimatedLuaSprite('lantern5','stages/dan_qiu/lantern', xOffset+940, yOffset+80);
	addAnimationByPrefix('lantern5','idle','deng2',24,true);
	objectPlayAnimation('lantern5','idle',true);
	setProperty('lantern5.flipX',true);
	scaleObject('lantern5', scale, scale);

	makeAnimatedLuaSprite('guest0','stages/dan_qiu/Guest/Guest',xOffset-40, yOffset-5);
	addAnimationByPrefix('guest0','idle','oilnkris',24,false);
	scaleObject('guest0', scale, scale);

	makeAnimatedLuaSprite('guest1','stages/dan_qiu/Guest/Guest',xOffset+0, yOffset+610);
	addAnimationByPrefix('guest1','idle','peoples0',24,false);
	addAnimationByPrefix('guest1','out','peoples comes out',24,false);
	scaleObject('guest1', scale, scale);


	addLuaSprite('sky', false);
	addLuaSprite('moon', false);
	addLuaSprite('mountain', false);	
	addLuaSprite('floor', false);
	addLuaSprite('lantern0', false);
	addLuaSprite('lantern1', false);
	addLuaSprite('lantern2', false);
	addLuaSprite('lantern3', false);
	addLuaSprite('lantern4', false);
	addLuaSprite('lantern5', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', true);
end
 
function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('guest0','idle',true);
		objectPlayAnimation('guest1','idle',true);
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
