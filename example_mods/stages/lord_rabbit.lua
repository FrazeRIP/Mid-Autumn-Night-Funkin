
local xOffset = -750
local yOffset = -170
local scale = .65

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

	makeAnimatedLuaSprite('guest4','stages/lord_rabbit/RopryGuest/RopryGuest4',  xOffset-15, yOffset+770);
	addAnimationByPrefix('guest4','idle','Ropry_Guest4',24,false);
	scaleObject('guest4', scale, scale);

	addLuaSprite('sky', false);
	addLuaSprite('bg', false);
	addLuaSprite('window', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guest2', false);
	addLuaSprite('guest3', false);
	addLuaSprite('rabbit', false);
	addLuaSprite('lantern', true);
	addLuaSprite('light', true);
	addLuaSprite('curtain', true);
	addLuaSprite('guest4', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
	objectPlayAnimation('guest4','idle',true);
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .53, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .53, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', .6, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .6, 0.0001)
end