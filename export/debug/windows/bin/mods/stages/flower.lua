function onCreate()
	makeLuaSprite('sky', 'stages/flower/NicoLayer0', 0, 0);
	setScrollFactor('sky', 0.9, 0.9);

	makeLuaSprite('archway', 'stages/flower/NicoLayer1', 0, 0);

	makeLuaSprite('bush_back', 'stages/flower/NicoLayer2', 0, 0);

	makeLuaSprite('ground', 'stages/flower/NicoLayer3', 0, 0);

	makeLuaSprite('tree', 'stages/flower/NicoLayer4', 0, 0);

	makeLuaSprite('decorated_archway', 'stages/flower/NicoLayer5', 0, 0);

	makeLuaSprite('light', 'stages/flower/NicoLayer6', 0, 0);

	makeAnimatedLuaSprite('guest0','stages/flower/NicoGuest/NicoGuest0', 0, 392);
	addAnimationByPrefix('guest0','idle','NicoGuest0',24,false);

	makeAnimatedLuaSprite('guest1','stages/flower/NicoGuest/NicoGuest1', 1710, 350);
	addAnimationByPrefix('guest1','idle','NicoGuest1',24,false);

	makeLuaSprite('bush_front', 'stages/flower/NicoLayer7', 0, 0);

	makeLuaSprite('branch', 'stages/flower/NicoLayer8', 0, 0);

	makeAnimatedLuaSprite('guest2','stages/flower/NicoGuest/NicoGuest2', -17, 1410);
	addAnimationByPrefix('guest2','idle','NicoGuest2',24,false);
	
	addLuaSprite('sky', false);
	addLuaSprite('archway', false);
	addLuaSprite('bush_back', false);
	addLuaSprite('ground', false);
	addLuaSprite('tree', false);
	addLuaSprite('decorated_archway', false);
	addLuaSprite('light', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('bush_front', false);
	addLuaSprite('branch', false);
	addLuaSprite('guest2', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
end