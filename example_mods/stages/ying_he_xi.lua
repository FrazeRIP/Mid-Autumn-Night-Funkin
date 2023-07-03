
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1

	
function onCreate()

	setPropertyFromGroup('backdropList', 0, 'y', 0)
	setPropertyFromGroup('backdropList', 1, 'y', 0)
	setPropertyFromGroup('backdropList',2, 'y', 0)
	setPropertyFromGroup('backdropList',3, 'y', 0)
	setPropertyFromGroup('backdropList',4, 'y', 0)

	setProperty('bgGroup.y',-100)

	makeAnimatedLuaSprite('kr','stages/ying_he_xi/MA_KR_PIXEL', 0 , 30 )
	scaleObject('kr', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('kr','idle','BoatKR IDLE',24,false);
	addAnimationByPrefix('kr','row','BoatKR Rowing',24,false);
	setProperty('kr.antialiasing', false);
	addLuaSprite('kr', false);

	makeLuaSprite('Layer0', 'stages/ying_he_xi/BoatCover', 0, 30 )
	scaleObject('Layer0', ScaleOffset, ScaleOffset);
	addLuaSprite('Layer0', true);
	
end

function onBeatHit()
	if curBeat % 2 == 0 then
	objectPlayAnimation('kr','idle',true);
	end

	if curBeat %16 == 0 then
	objectPlayAnimation('kr','row',true);
	end
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', 1, 0.0001)
	doTweenY('gfScaley', 'gf.scale', 1, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', 1, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', 1, 0.0001)

	
	doTweenX('BGLX', 'BGLight', -70, 0.0001)
	setScrollFactor('BGLight', 0.8, 1);
	setProperty('BGLight.antialiasing', false);
	doTweenX('BGX', 'BG', -70, 0.0001)
	setScrollFactor('BG', 0.8, 1);
	setProperty('BG.antialiasing', false);
	
	local guestY = 6

	doTweenY('Guest1Y', 'Guest1', guestY, 0.0001)
	doTweenY('Guest2Y', 'Guest2', guestY, 0.0001)
	doTweenY('Guest3Y', 'Guest3', guestY, 0.0001)
	doTweenY('Guest4Y', 'Guest4', guestY, 0.0001)
	doTweenY('Guest5Y', 'Guest5', guestY, 0.0001)
	doTweenY('Guest6Y', 'Guest6', guestY, 0.0001)
	doTweenY('Guest7Y', 'Guest7', guestY, 0.0001)

end
