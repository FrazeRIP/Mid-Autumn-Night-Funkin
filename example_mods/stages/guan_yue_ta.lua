local folderName = 'stages'
local stageName = 'Rincy'

local xOffset = -870
local yOffset = -140
local scale = .65

function onCreate()
	local path = folderName..'/'..stageName..'/'

	makeAnimatedLuaSprite('bg0', path..'RincyLayer0', xOffset+420, yOffset-80);
	addAnimationByPrefix('bg0','RincyLayer0','RincyLayer0',48,true);
	setScrollFactor('bg0', .3, .3);
	scaleObject('bg0', scale, scale);
	addLuaSprite('bg0', false);

	makeAnimatedLuaSprite('guest1', path..'/RincyGuest/'..'RincyGuest1',  850, 220);
	addAnimationByPrefix('guest1','RincyGuest1','RincyGuest1',24,false);
	setScrollFactor('guest1', .6, .5);
	scaleObject('guest1', scale, scale);
	addLuaSprite('guest1', false);
	
	makeAnimatedLuaSprite('guest2', path..'/RincyGuest/'..'RincyGuest2', 875, -80);
	addAnimationByPrefix('guest2','RincyGuest2','RincyGuest2',24,false);	
	setScrollFactor('guest2', .6, .5);
	scaleObject('guest2', scale, scale);	
	addLuaSprite('guest2', false);

	makeLuaSprite('bg7', path..'RincyLayer7', xOffset+610, yOffset+0);
	setScrollFactor('bg7', .6, .5);
	scaleObject('bg7', scale-0.1, scale-0.1);
	addLuaSprite('bg7', false);
	
	makeLuaSprite('whiteFade2','mechanism/Rincy/Ink/whiteFade', -1000,-150);
	scaleObject('whiteFade2', 2, 1.5);
	addLuaSprite('whiteFade2', false);
	setBlendMode('whiteFade2', 'add')
	doTweenAlpha("whiteFade2A","whiteFade2",0, 0.0001)

	makeLuaSprite('bg1', path..'RincyLayer1', xOffset+180, yOffset+0);
	setScrollFactor('bg1', 1, 1);
	scaleObject('bg1', scale, scale);
	addLuaSprite('bg1', false);

	makeLuaSprite('bg2', path..'RincyLayer2', xOffset+110, yOffset+0);
	setScrollFactor('bg2', 1, 1);
	scaleObject('bg2', scale, scale);
	addLuaSprite('bg2', false);

	makeLuaSprite('bg3', path..'RincyLayer3', xOffset+110, yOffset+0);
	setScrollFactor('bg3', 1, 1);
	scaleObject('bg3', scale, scale);
	addLuaSprite('bg3', false);


	makeLuaSprite('bg4', path..'RincyLayer4', xOffset+150, yOffset+0);
	setScrollFactor('bg4', 1, 1);
	scaleObject('bg4', scale, scale);
	addLuaSprite('bg4', false);
	
	makeLuaSprite('bg5L', path..'RincyLayer5_Single', xOffset-50, yOffset+200);
	setScrollFactor('bg5L', 1, 1);
	scaleObject('bg5L', scale, scale);
	addLuaSprite('bg5L', false);

	--makeLuaSprite('bg5', path..'RincyLayer5', xOffset-200, yOffset+0);
	--setScrollFactor('bg5', 1, 1);
	--scaleObject('bg5', scale, scale);
	--addLuaSprite('bg5', true);

	makeLuaSprite('bg6', path..'RincyLayer6', xOffset+110, yOffset+0);
	setScrollFactor('bg6', 1, 1);
	scaleObject('bg6', scale, scale);
	addLuaSprite('bg6', true);


	
	makeAnimatedLuaSprite('guest0', path..'/RincyGuest/'..'RincyGuest0', 380, 200);
	addAnimationByPrefix('guest0','RincyGuest0','RincyGuest0',24,false);
	setScrollFactor('guest0', .9, .9);
	scaleObject('guest0', scale, scale);
	addLuaSprite('guest0', false);
	
	
	makeAnimatedLuaSprite('guest3', path..'/RincyGuest/'..'RincyGuest3', xOffset-50, 600);
	addAnimationByPrefix('guest3','RincyGuest3','RincyGuest3',24,false);
	setScrollFactor('guest3', 1.25, 1);
	scaleObject('guest3', scale+.05, scale+.05);
	addLuaSprite('guest3', true);
	
	makeAnimatedLuaSprite('guest4', path..'/RincyGuest/'..'RincyGuest4', -850, -50);
	addAnimationByPrefix('guest4','RincyGuest4','RincyGuest4',24,false);
	setScrollFactor('guest4', 1, 1);
	scaleObject('guest4', scale, scale);
	addLuaSprite('guest4', false);
	
	makeAnimatedLuaSprite('guest5', path..'/RincyGuest/'..'RincyGuest5',-650, -110);
	addAnimationByPrefix('guest5','RincyGuest5','RincyGuest5',24,false);
	setScrollFactor('guest5', 1, 1);
	scaleObject('guest5',  scale, scale);
	addLuaSprite('guest5', false);
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .53, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .53, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', .6, 0.0001)
	doTweenY('dadScaley', 'dad.scale', .6, 0.0001)
end


function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('guest0','RincyGuest0',true);
		objectPlayAnimation('guest1','RincyGuest1',true);
		objectPlayAnimation('guest2','RincyGuest2',true);
		objectPlayAnimation('guest3','RincyGuest3',true);
		objectPlayAnimation('guest4','RincyGuest4',true);
		objectPlayAnimation('guest5','RincyGuest5',true);
	end
end