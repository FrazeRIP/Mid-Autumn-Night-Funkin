
local xOffset = 0
local yOffset = 0
local scale = 1

local secPerBeat

function onCreate()
	makeLuaSprite('sky', 'stages/yu_long_mei/SarahLayer4',xOffset-50, yOffset+0);
	setScrollFactor('sky', 0.75, 0.75);
	scaleObject('sky', scale, scale);

	makeLuaSprite('floor', 'stages/yu_long_mei/SarahLayer3', xOffset+ 0, yOffset+0);
	scaleObject('floor', scale, scale);

	makeLuaSprite('light', 'stages/yu_long_mei/SarahLayer2', xOffset+ 0, yOffset+0);
	scaleObject('light', scale, scale);

	makeLuaSprite('candle', 'stages/yu_long_mei/SarahLayer1', xOffset+ 0, yOffset+0);
	scaleObject('candle', scale, scale);


	addLuaSprite('sky', false);	
	addLuaSprite('floor', false);
	addLuaSprite('light', false);
	addLuaSprite('candle', false);
	
end
 
function onBeatHit()
	
end


function onCreatePost( ... )
	
end


