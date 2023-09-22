

local xOffset = -680
local yOffset = -480
local scale = .72


function onCreate()
	
	makeLuaSprite('sky', 'stages/calligraphy/SproutLayer0', xOffset+0, yOffset+0);
	setScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', scale, scale);	

	makeAnimatedLuaSprite('bg','stages/calligraphy/SproutLayer1', xOffset-40, yOffset+436);
	addAnimationByPrefix('bg','idle','SproutLayer1',24,false);
	scaleObject('bg', scale, scale);	

	makeLuaSprite('lantern', 'stages/calligraphy/SproutLayer2', xOffset+0, yOffset+0);
	scaleObject('lantern', scale, scale);	

	makeLuaSprite('eaves', 'stages/calligraphy/SproutLayer3',  xOffset+0, yOffset+0);
	scaleObject('eaves', scale, scale);	

	makeAnimatedLuaSprite('guest0','stages/calligraphy/SproutGuest/SproutGuest0',  xOffset+110, yOffset+950);
	addAnimationByPrefix('guest0','idle','SproutGuest0',24,false);
	scaleObject('guest0', scale, scale);	

	makeAnimatedLuaSprite('guest1','stages/calligraphy/SproutGuest/SproutGuest1',  xOffset+1165, yOffset+700);
	addAnimationByPrefix('guest1','idle','SproutGuest1',24,false);
	scaleObject('guest1', scale+.2, scale+.2);	

	makeAnimatedLuaSprite('guest2','stages/calligraphy/SproutGuest/SproutGuest2',  xOffset+1500, yOffset+650);
	addAnimationByPrefix('guest2','idle','SproutGuest2',24,false);
	scaleObject('guest2', scale+.2, scale+.2);		
	
	makeAnimatedLuaSprite('guest3','stages/calligraphy/SproutGuest/SproutGuest3',  xOffset+0, yOffset+1160);
	addAnimationByPrefix('guest3','idle','SproutGuest3',24,false);
	scaleObject('guest3', scale, scale);	
	setScrollFactor('guest3', 1, 0.3);

	addLuaSprite('sky', false);
	addLuaSprite('bg', false);
	addLuaSprite('lantern', false);
	addLuaSprite('eaves', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guest2', false);
	addLuaSprite('guest3', true);
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
	objectPlayAnimation('bg','idle',true);
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
	end
end

function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .55, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .55, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', .68, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .68, 0.0001)

	doTweenX('BFscaleX', 'boyfriend.scale', .7, 0.0001)
	doTweenY('BFscaleY', 'boyfriend.scale', .7, 0.0001)
end
