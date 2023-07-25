function onCreate()
	makeLuaSprite('sky', 'stages/moon_cake_betting/PinkGhostLayer0', -50, 0);
	setScrollFactor('sky', 0.95, 0.95);

	makeLuaSprite('stage', 'stages/moon_cake_betting/PinkGhostLayer1', 0, 0);

	makeLuaSprite('cover', 'stages/moon_cake_betting/PinkGhostLayer2', 0, 0);

	makeAnimatedLuaSprite('guest0','stages/moon_cake_betting/PinkGhostGuest/PinkGhostGuest2', 200, 370);
	addAnimationByPrefix('guest0','idle','backdrop6',24,false);
	makeAnimatedLuaSprite('guest1','stages/moon_cake_betting/PinkGhostGuest/PinkGhostGuest3', 2100, 416);
	addAnimationByPrefix('guest1','idle','backdrop7',24,false);
	
	makeAnimatedLuaSprite('guestFront','stages/moon_cake_betting/PinkGhostGuest/PinkGhostGuest1', -140, 900);
	addAnimationByPrefix('guestFront','idle','backdrop5',24,false);
	setScrollFactor('guestFront', .8, .8);

	addLuaSprite('sky', false);
	addLuaSprite('stage', false);
	addLuaSprite('cover', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guestFront', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guestFront','idle',true);
end


function onCreatePost( ... )
	doTweenX('gfScaleX', 'gf.scale', .65, 0.0001)
	doTweenY('gfScaley', 'gf.scale', .65, 0.0001)

	doTweenX('dadScaleX', 'dad.scale', 1, 0.0001)
	doTweenY('dadScaley', 'dad.scale', 1, 0.0001)

	doTweenX('bfScaleX', 'boyfriend.scale', .8, 0.0001)
	doTweenY('bfScaley', 'boyfriend.scale', .8, 0.0001)
end
