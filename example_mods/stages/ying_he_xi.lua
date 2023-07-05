
local Xoffset = -1400
local Yoffset = -170
local ScaleOffset = 1

function onCreate()

	setProperty('bgGroup.y',-100)
	

	makeAnimatedLuaSprite('kr','stages/ying_he_xi/MA_KR_PIXEL', 0 , 30 )
	scaleObject('kr', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('kr','idle','BoatKR IDLE',24,false);
	addAnimationByPrefix('kr','row','BoatKR Rowing',24,false);
	setProperty('kr.antialiasing', false);

	makeLuaSprite('Layer0', 'stages/ying_he_xi/BoatCover', 0, 30 )
	scaleObject('Layer0', ScaleOffset, ScaleOffset);
	
	makeLuaSprite('lotus1', 'stages/ying_he_xi/Guest/lotus1',0, 90 )
	scaleObject('lotus1', .9, .9);

	makeLuaSprite('lotus1-1', 'stages/ying_he_xi/Guest/lotus2',400, 130 )
	
	makeLuaSprite('lotus2', 'stages/ying_he_xi/Guest/lotus3', -80, 160 )

	--makeLuaSprite('lotus2-1', 'stages/ying_he_xi/Guest/lotus1', 380, 180 );

	makeLuaSprite('lotus3', 'stages/ying_he_xi/Guest/lotus3', 180, 200 )

	makeLuaSprite('lotus3-1', 'stages/ying_he_xi/Guest/lotus2', -250, 210 )
	
	makeLuaSprite('boat', 'stages/ying_he_xi/Guest/9',-400, 35 )


	
	addLuaSprite('lotus1', false);
	addLuaSprite('boat', false);
	addLuaSprite('lotus1-1', false);
	addLuaSprite('kr', false);
	addLuaSprite('Layer0', true);
	addLuaSprite('lotus2', true);
	addLuaSprite('lotus2-1', true);
	addLuaSprite('lotus3', true);
	addLuaSprite('lotus3-1', true);

	
end

function onUpdate(elapsed)

	lotusEvent('lotus1',22,elapsed)
	lotusEvent('lotus1-1',22,elapsed)
	lotusEvent('lotus2',26,elapsed)
	--lotusEvent('lotus2-1',26,elapsed)
	lotusEvent('lotus3',30,elapsed)
	lotusEvent('lotus3-1',30,elapsed)

	if curBeat >= 112 then
	local boatX= getProperty('boat.x')
	setProperty('boat.x',boatX+20*elapsed);
	end

end

function lotusEvent(lotus,speed,elapsed)

	local lotusX= getProperty(lotus..'.x')
	if lotusX > 550 then
		lotusX = -200
		setProperty(lotus..'.x',lotusX);
	end
	setProperty(lotus..'.x',lotusX+speed*elapsed);
end

function onBeatHit()
	if curBeat % 2 == 0 then
	objectPlayAnimation('kr','idle',true);
	end

	if curBeat %16 == 0 then
	objectPlayAnimation('kr','row',true);
	end

	if curBeat == 32 then
	showGuest(false)
	end
	
	if curBeat == 63 then
	showGuest(true)
	end
	
	if curBeat == 99 then
	showGuest(true)
	end
	
	if curBeat == 124 then
	showGuest(false)
	end
	
	if curBeat == 142 then
	showGuest(true)
	end
	
	if curBeat == 167 then
	showGuest(false)
	end
	
	if curBeat == 192 then
	showGuest(true)
	end
	
	if curBeat == 214 then
	showGuest(false)
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
	
	local guestY = 0
	local guestX = -220

	doTweenY('Guest1Y', 'Guest1', 8 +guestY, 0.0001)-- 6
	doTweenY('Guest2Y', 'Guest2', 8 +guestY, 0.0001)-- 6
	doTweenY('Guest3Y', 'Guest3', -15 +guestY, 0.0001)-- -15
	doTweenY('Guest4Y', 'Guest4', -5 +guestY, 0.0001) -- -5
	doTweenY('Guest5Y', 'Guest5', -19 +guestY, 0.0001)-- -19
	doTweenY('Guest6Y', 'Guest6', 24 +guestY, 0.0001)-- 24
	doTweenY('Guest7Y', 'Guest7', -5 +guestY, 0.0001)-- -5

	doTweenX('Guest1X', 'Guest1', guestX, 0.0001)
	doTweenX('Guest2X', 'Guest2', guestX, 0.0001)
	doTweenX('Guest3X', 'Guest3', guestX, 0.0001)
	doTweenX('Guest4X', 'Guest4', guestX, 0.0001)
	doTweenX('Guest5X', 'Guest5', guestX, 0.0001)
	doTweenX('Guest6X', 'Guest6', guestX, 0.0001)
	doTweenX('Guest7X', 'Guest7', guestX, 0.0001)
end

function showGuest(isTall)
	debugPrint("Triggered. curBeat:" ,curBeat, " isTall:",isTall)
	setProperty('isGuestAppear', true);
	if isTall then
	setProperty('guestYOffset', 0)
	else
	setProperty('guestYOffset',14)
	end
end
