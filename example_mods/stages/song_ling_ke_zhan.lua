
local Xoffset = -2500
local Yoffset = -1000
local ScaleOffset = 1

local factor = 8
	
function onCreate()
	
	makeLuaSprite('Layer0', 'stages/song_ling_ke_zhan/Layer0', 0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer0', ScaleOffset, ScaleOffset);
	makeLuaSprite('Layer1', 'stages/song_ling_ke_zhan/Layer1', 0 +Xoffset, 0 + Yoffset)
	scaleObject('Layer1', ScaleOffset, ScaleOffset);

	makeLuaSprite('Layer2', 'stages/song_ling_ke_zhan/Layer2',0 +Xoffset, -50 + Yoffset)
	scaleObject('Layer2', ScaleOffset, ScaleOffset);
	setScrollFactor('Layer2', 1.2, 1.2);
	makeLuaSprite('Layer3', 'stages/song_ling_ke_zhan/Layer3',-100 +Xoffset, -50 + Yoffset)
	scaleObject('Layer3', ScaleOffset, ScaleOffset);
	setScrollFactor('Layer3', 1.5, 1.5);

	makeAnimatedLuaSprite('guest0','stages/song_ling_ke_zhan/Guest/Guest0', -1700 , -320 )
	scaleObject('guest0', ScaleOffset -.15, ScaleOffset -.15);
	addAnimationByPrefix('guest0','idle','Guest0',24,false);
	
	makeAnimatedLuaSprite('guest3','stages/song_ling_ke_zhan/Guest/Guest3',  700 ,  -200  )
	scaleObject('guest3', ScaleOffset-.15, ScaleOffset-.15);
	addAnimationByPrefix('guest3','idle','Guest3',24,false);
	
	makeAnimatedLuaSprite('guest1','stages/song_ling_ke_zhan/Guest/Guest1', 50 ,  -450 )
	scaleObject('guest1', ScaleOffset -.15, ScaleOffset -.15);
	addAnimationByPrefix('guest1','idle','Guest1',24,false);
	

	makeAnimatedLuaSprite('guest2','stages/song_ling_ke_zhan/Guest/Guest2',  -800 ,  -400   )
	scaleObject('guest2', ScaleOffset-.1, ScaleOffset-.1);
	addAnimationByPrefix('guest2','idle','Guest2',24,false);


	addLuaSprite('Layer0', false);

	addLuaSprite('guest2', false);

	addLuaSprite('Layer1', false);

	addLuaSprite('guest1', false);

	addLuaSprite('guest0', false);
	addLuaSprite('guest3', false);

	addLuaSprite('Layer2', false);
	addLuaSprite('Layer3', false);

	makeLuaSprite('solidB', '', -2000, -1000);
	makeGraphic('solidB', '4000','3000', '000000')
	addLuaSprite('solidB')
end

function onStepHit()
	
	if curStep == 608 then
		factor = 4
	end
	
	
	if curStep == 1120 then
		factor = 8
	end

	if curStep % factor == 0 then
		objectPlayAnimation('guest0','idle',true);
		objectPlayAnimation('guest1','idle',true);
		objectPlayAnimation('guest2','idle',true);
		objectPlayAnimation('guest3','idle',true);
	end
end


function onCreatePost( ... )
	doTweenX('SX', 'dad.scale', 1, .00001)
	doTweenY('SY', 'dad.scale', 1, .00001)
	doTweenX('bfSX', 'boyfriend.scale', .8, .00001)
	doTweenY('bfSY', 'boyfriend.scale', .8,.00001)
	doTweenX('gfSX', 'gf.scale', .7, .00001)
	doTweenY('gfSY', 'gf.scale', .7, .00001)
end
