
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1

	
function onCreate()

	scaleObject('Layer3', ScaleOffset, ScaleOffset);
	makeAnimatedLuaSprite('kr','stages/ying_he_xi/MA_KR_PIXEL', 0 , 0 )
	scaleObject('kr', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('kr','idle','BoatKR IDLE',24,false);
	addAnimationByPrefix('kr','row','BoatKR Rowing',24,false);
	addLuaSprite('kr', false);
	setProperty('kr.antialiasing', false);

	makeLuaSprite('Layer0', 'stages/ying_he_xi/HeidiLayer8', 0, 0 )
	scaleObject('Layer0', ScaleOffset, ScaleOffset);
	addLuaSprite('Layer0', true);
	
end

function onBeatHit()
	objectPlayAnimation('kr','idle',true);
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', 1, 0.0001)
	doTweenY('gfScaley', 'gf.scale', 1, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', 1, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', 1, 0.0001)
end
