
local Xoffset = -1450
local Yoffset = -1800
local ScaleOffset = 1.45

	
function onCreate()
	makeLuaSprite('PaolaLayer0', 'stages/deng_yun_tai/PaolaLayer0', -50 +Xoffset, 0 + Yoffset)
	setScrollFactor('PaolaLayer0', 0.95, 0.95);
	scaleObject('PaolaLayer0', ScaleOffset, ScaleOffset);

	makeLuaSprite('PaolaLayer1', 'stages/deng_yun_tai/PaolaLayer1', 0 +Xoffset, 0 + Yoffset)
	scaleObject('PaolaLayer1', ScaleOffset, ScaleOffset);
	makeLuaSprite('PaolaLayer2', 'stages/deng_yun_tai/PaolaLayer2',0 +Xoffset, 0 + Yoffset)
	scaleObject('PaolaLayer2', ScaleOffset, ScaleOffset);
	makeLuaSprite('PaolaLayer3', 'stages/deng_yun_tai/PaolaLayer3',0 +Xoffset, 0 + Yoffset)
	scaleObject('PaolaLayer3', ScaleOffset, ScaleOffset);
	makeLuaSprite('PaolaLayer4', 'stages/deng_yun_tai/PaolaLayer4', 0 +Xoffset, 200 + Yoffset)
	scaleObject('PaolaLayer4', ScaleOffset, ScaleOffset);
	makeLuaSprite('PaolaLayer5', 'stages/deng_yun_tai/PaolaLayer5',0 +Xoffset, 200 + Yoffset)
	scaleObject('PaolaLayer5', ScaleOffset, ScaleOffset);

	makeAnimatedLuaSprite('guest0','stages/deng_yun_tai/Guest/PaolaGuest0', -1150 , -100 )
	scaleObject('guest0', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest0','idle','PaolaGuest0',24,false);
	
	makeAnimatedLuaSprite('guest1','stages/deng_yun_tai/Guest/PaolaGuest1', -1200 ,  -300 )
	scaleObject('guest1', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest1','idle','PaolaGuest1',24,false);
	
	makeAnimatedLuaSprite('guest2','stages/deng_yun_tai/Guest/PaolaGuest2',  1100 ,  -100   )
	scaleObject('guest2', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest2','idle','PaolaGuest2',24,false);

	addLuaSprite('PaolaLayer0', false);
	addLuaSprite('PaolaLayer1', false);
	addLuaSprite('PaolaLayer2', false);
	addLuaSprite('guest1', false);
	addLuaSprite('PaolaLayer3', false);
	addLuaSprite('PaolaLayer4', false);
	addLuaSprite('PaolaLayer5', false);

	addLuaSprite('guest0', false);
	addLuaSprite('guest2', false);
end

function onBeatHit()
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
end


function onCreatePost( ... )
	doTweenX('paolaSX', 'dad.scale', .9, .00001)
	doTweenY('paolaSY', 'dad.scale', .9, .00001)
	doTweenX('bfSX', 'boyfriend.scale', 1, .00001)
	doTweenY('bfSY', 'boyfriend.scale', 1,.00001)
	doTweenX('gfSX', 'gf.scale', .75, .00001)
	doTweenY('gfSY', 'gf.scale', .75, .00001)
end
