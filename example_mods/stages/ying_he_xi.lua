
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1.65

	
function onCreate()
	makeLuaSprite('Layer0', 'stages/ying_he_xi/HeidiLayer0', 0 +Xoffset, 0 + Yoffset)
	setScrollFactor('Layer0', 0.75, 0.75);
	scaleObject('Layer0', ScaleOffset, ScaleOffset);

	makeLuaSprite('Layer1', 'stages/ying_he_xi/HeidiLayer1', 0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer1', ScaleOffset, ScaleOffset);
	makeLuaSprite('Layer2', 'stages/ying_he_xi/HeidiLayer2',0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer2', ScaleOffset, ScaleOffset);
	makeLuaSprite('Layer3', 'stages/ying_he_xi/HeidiLayer3',0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer3', ScaleOffset, ScaleOffset);
	runHaxeCode([[
var backdrop = new FlxBackdrop(Paths.modsImage("stages/ying_he_xi/HeidiLayer2"));
backdrop.scrollFactor.set(1£¬1);
backdrop.velocity.set(1£¬1);
backdrop.camera = camGame;
add(backdrop);
]])
	debugPrint("Triggered")
	--makeAnimatedLuaSprite('guest0','stages/ying_he_xi/Guest/1', -850 , 230 )
	--scaleObject('guest0', ScaleOffset, ScaleOffset);
	--addAnimationByPrefix('guest0','idle','WhitecatGuest0',24,false);
	
	--makeAnimatedLuaSprite('guest1','stages/ying_he_xi/Guest/2', 550 ,  230 )
	--scaleObject('guest1', ScaleOffset, ScaleOffset);
	--addAnimationByPrefix('guest1','idle','WhitecatGuest1',24,false);
	
	--makeAnimatedLuaSprite('guest2','stages/ying_he_xi/Guest/3',  -1350 ,  830   )
	--scaleObject('guest2', ScaleOffset, ScaleOffset);
	--setScrollFactor('guest2', .8, .8);
	--addAnimationByPrefix('guest2','idle','WhitecatGuest2',24,false);

	addLuaSprite('Layer0', false);
	addLuaSprite('Layer1', false);
	addLuaSprite('Layer2', false);
	addLuaSprite('Layer3', false);

	--addLuaSprite('guest0', false);
	--addLuaSprite('guest1', false);
	--addLuaSprite('guest2', true);
end

function onBeatHit()
	--objectPlayAnimation('guest0','idle',true);
	--objectPlayAnimation('guest1','idle',true);
	--objectPlayAnimation('guest2','idle',true);
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .5, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .5, 0.0001)

	--doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	--doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', .6, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', .6, 0.0001)
end
