
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1

function onCreate()
	setProperty('bgGroup.y',-100)
	
	makeAnimatedLuaSprite('kr','stages/ying_he_xi/MA_KR_PIXEL', 280, 167 )
	scaleObject('kr', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('kr','idle','BoatKR IDLE',24,false);
	setProperty('kr.antialiasing', false);

	makeLuaSprite('Layer0', 'stages/ying_he_xi/Layer0', 0, 0 )
	scaleObject('Layer0', ScaleOffset, ScaleOffset);
	
	addLuaSprite('Layer0', false);
	addLuaSprite('kr', true);
end


function onBeatHit()
	if curBeat % 2 == 0 then
	objectPlayAnimation('kr','idle',true);
	end

end

function onCreatePost( ... )

	doTweenX('gfScaleX', 'gf.scale', 1, 0.0001)
	doTweenY('gfScaley', 'gf.scale', 1, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', 1, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', 1, 0.0001)

end
