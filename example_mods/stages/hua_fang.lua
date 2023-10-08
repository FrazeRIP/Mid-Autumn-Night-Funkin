
local folderName = 'stages'
local stageName = 'hua_fang'

local xOffset = -790
local yOffset = -140
local scale = .75



function onCreate()
	makeLuaSprite('sky', 'stages/hua_fang/NicoLayer0', xOffset+0, yOffset+0);
	setScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', scale, scale);

	makeLuaSprite('archway', 'stages/hua_fang/NicoLayer1', xOffset+0, yOffset+0);
	scaleObject('archway', scale, scale);

	makeLuaSprite('bush_back', 'stages/hua_fang/NicoLayer2', xOffset+0, yOffset+0);
	scaleObject('bush_back', scale, scale);

	makeLuaSprite('ground', 'stages/hua_fang/NicoLayer3', xOffset+0, yOffset+0);
	scaleObject('ground', scale, scale);

	makeLuaSprite('tree', 'stages/hua_fang/NicoLayer4', xOffset+0, yOffset+0);
	scaleObject('tree', scale, scale);

	makeLuaSprite('decorated_archway', 'stages/hua_fang/NicoLayer5', xOffset+0, yOffset+0);
	scaleObject('decorated_archway', scale, scale);

	makeLuaSprite('light', 'stages/hua_fang/NicoLayer6', xOffset+0, yOffset+0);
	scaleObject('light', scale, scale);

	makeAnimatedLuaSprite('guest0','stages/hua_fang/NicoGuest/NicoGuest0', -700, 300);
	addAnimationByPrefix('guest0','idle','NicoGuest0',24,false);
	scaleObject('guest0', scale, scale);

	makeAnimatedLuaSprite('guest1','stages/hua_fang/NicoGuest/NicoGuest1', 550, 300);
	addAnimationByPrefix('guest1','idle','NicoGuest1',24,false);
	scaleObject('guest1', scale, scale);

	makeLuaSprite('bush_front', 'stages/hua_fang/NicoLayer7', xOffset+0, yOffset+0);
	scaleObject('bush_front', scale, scale);

	makeLuaSprite('branch', 'stages/hua_fang/NicoLayer8',xOffset+0, yOffset+0);
	scaleObject('branch', scale, scale);

	makeAnimatedLuaSprite('guest2','stages/hua_fang/NicoGuest/NicoGuest2', -750, 850);
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
	
	makePexParticle("nico_petal",-1200,100,1,"camGame")
	setParticleBlendMode("nico_petal",'normal')
	addLuaSprite('guest2', true);
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	end
end



function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .53, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .53, 0.0001)
	
	doTweenX('dadScaleX', 'dad.scale', .65, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .65, 0.0001)
end