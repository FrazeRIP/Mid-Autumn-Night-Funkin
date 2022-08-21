function onCreate()
	makeLuaSprite('sky', 'stages/moon_cake_betting/PinkGhostLayer0', -50, 0);
	setScrollFactor('sky', 0.95, 0.95);

	makeLuaSprite('stage', 'stages/moon_cake_betting/PinkGhostLayer1', 0, 0);

	makeLuaSprite('toast', 'stages/moon_cake_betting/PinkGhostLayer2', 1960, 125);

	makeAnimatedLuaSprite('guest0','stages/moon_cake_betting/PinkGhostGuest/PinkGhostGuest', 296, 416);
	addAnimationByPrefix('guest0','idle','backdrop',24,false);

	addLuaSprite('sky', false);
	addLuaSprite('stage', false);
	addLuaSprite('toast', false);
	addLuaSprite('guest0', false);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
end