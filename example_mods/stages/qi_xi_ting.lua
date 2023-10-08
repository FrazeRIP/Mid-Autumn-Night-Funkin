function onCreate()
	makeLuaSprite('sky', 'stages/qi_xi_ting/PinkGhostLayer0', -50, 0);
	setScrollFactor('sky', 0.95, 0.95);

	makeLuaSprite('stage', 'stages/qi_xi_ting/PinkGhostLayer1', 0, 0);

	makeLuaSprite('cover', 'stages/qi_xi_ting/PinkGhostLayer2', 0, 0);

	makeAnimatedLuaSprite('guest0','stages/qi_xi_ting/PinkGhostGuest/PinkGhostGuest2', 200, 370);
	addAnimationByPrefix('guest0','idle','backdrop6',36,false);
	makeAnimatedLuaSprite('guest1','stages/qi_xi_ting/PinkGhostGuest/PinkGhostGuest3', 2100, 416);
	addAnimationByPrefix('guest1','idle','backdrop7',36,false);
	
	makeAnimatedLuaSprite('guestFront','stages/qi_xi_ting/PinkGhostGuest/PinkGhostGuest1', -140, 900);
	addAnimationByPrefix('guestFront','idle','backdrop5',36,false);
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
