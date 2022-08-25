function onCreate()
	makeLuaSprite('sky', 'stages/calligraphy/SproutLayer0', 0, 0);
	setScrollFactor('sky', 0.9, 0.9);

	makeAnimatedLuaSprite('bg','stages/calligraphy/SproutLayer1', 10, 436);
	addAnimationByPrefix('bg','idle','SproutLayer1',24,false);

	makeLuaSprite('lantern', 'stages/calligraphy/SproutLayer2', 0, 0);

	makeLuaSprite('eaves', 'stages/calligraphy/SproutLayer3', 0, 0);

	makeAnimatedLuaSprite('guest0','stages/calligraphy/SproutGuest/SproutGuest0', 134, 1163);
	addAnimationByPrefix('guest0','idle','SproutGuest0',24,false);

	makeAnimatedLuaSprite('guest1','stages/calligraphy/SproutGuest/SproutGuest1', 1758, 989);
	addAnimationByPrefix('guest1','idle','SproutGuest1',24,false);

	makeAnimatedLuaSprite('guest2','stages/calligraphy/SproutGuest/SproutGuest2', 2063, 970);
	addAnimationByPrefix('guest2','idle','SproutGuest2',24,false);
	
	makeAnimatedLuaSprite('guest3','stages/calligraphy/SproutGuest/SproutGuest3', 180, 1580);
	addAnimationByPrefix('guest3','idle','SproutGuest3',24,false);

	addLuaSprite('sky', false);
	addLuaSprite('bg', false);
	addLuaSprite('lantern', false);
	addLuaSprite('eaves', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guest2', false);
	addLuaSprite('guest3', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('bg','idle',true);
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
end