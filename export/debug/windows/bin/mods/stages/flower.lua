
local folderName = 'stages'
local stageName = 'flower'

local xOffset = -790
local yOffset = -140
local scale = .75



function onCreate()
	makeLuaSprite('sky', 'stages/flower/NicoLayer0', xOffset+0, yOffset+0);
	setScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', scale, scale);

	makeLuaSprite('archway', 'stages/flower/NicoLayer1', xOffset+0, yOffset+0);
	scaleObject('archway', scale, scale);

	makeLuaSprite('bush_back', 'stages/flower/NicoLayer2', xOffset+0, yOffset+0);
	scaleObject('bush_back', scale, scale);

	makeLuaSprite('ground', 'stages/flower/NicoLayer3', xOffset+0, yOffset+0);
	scaleObject('ground', scale, scale);

	makeLuaSprite('tree', 'stages/flower/NicoLayer4', xOffset+0, yOffset+0);
	scaleObject('tree', scale, scale);

	makeLuaSprite('decorated_archway', 'stages/flower/NicoLayer5', xOffset+0, yOffset+0);
	scaleObject('decorated_archway', scale, scale);

	makeLuaSprite('light', 'stages/flower/NicoLayer6', xOffset+0, yOffset+0);
	scaleObject('light', scale, scale);

	makeAnimatedLuaSprite('guest0','stages/flower/NicoGuest/NicoGuest0', -750, 150);
	addAnimationByPrefix('guest0','idle','NicoGuest0',24,false);
	scaleObject('guest0', scale, scale);

	makeAnimatedLuaSprite('guest1','stages/flower/NicoGuest/NicoGuest1', 500, 150);
	addAnimationByPrefix('guest1','idle','NicoGuest1',24,false);
	scaleObject('guest1', scale, scale);

	makeLuaSprite('bush_front', 'stages/flower/NicoLayer7', xOffset+0, yOffset+0);
	scaleObject('bush_front', scale, scale);

	makeLuaSprite('branch', 'stages/flower/NicoLayer8',xOffset+0, yOffset+0);
	scaleObject('branch', scale, scale);

	makeAnimatedLuaSprite('guest2','stages/flower/NicoGuest/NicoGuest2', -750, 900);
	addAnimationByPrefix('guest2','idle','NicoGuest2',24,false);
	scaleObject('guest2', scale, scale);
	
	addLuaSprite('sky', false);
	addLuaSprite('archway', false);
	addLuaSprite('bush_back', false);
	addLuaSprite('ground', false);
	addLuaSprite('tree', false);
	addLuaSprite('decorated_archway', false);
	addLuaSprite('light', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('bush_front', false);
	addLuaSprite('branch', false);
	addLuaSprite('guest2', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
end



function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .53, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .53, 0.0001)
	
	doTweenX('dadScaleX', 'dad.scale', .65, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .65, 0.0001)
end