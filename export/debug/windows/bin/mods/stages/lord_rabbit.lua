function onCreate()
	makeLuaSprite('sky', 'stages/lord_rabbit/RopryLayer0', 0, 0);
	setScrollFactor('sky', 0.8, 0.8);

	makeLuaSprite('bg', 'stages/lord_rabbit/RopryLayer1', 0, 0);

	makeLuaSprite('window', 'stages/lord_rabbit/RopryLayer2', 0, 0);

	makeAnimatedLuaSprite('guest0','stages/lord_rabbit/RopryGuest/RopryGuest0', 300, 400);
	addAnimationByPrefix('guest0','idle','RopryGuest0',24,false);

	makeAnimatedLuaSprite('guest1','stages/lord_rabbit/RopryGuest/RopryGuest1', 2000, 420);
	addAnimationByPrefix('guest1','idle','RopryGuest1',24,false);

	makeAnimatedLuaSprite('guest2','stages/lord_rabbit/RopryGuest/RopryGuest2', 900, 300);
	addAnimationByPrefix('guest2','idle','RopryGuest2',24,false);
	
	makeAnimatedLuaSprite('guest3','stages/lord_rabbit/RopryGuest/RopryGuest3', 1500, 320);
	addAnimationByPrefix('guest3','idle','Ropry_Guest3',24,false);

	makeLuaSprite('rabbit', 'stages/lord_rabbit/RopryLayer3', -237, 0);

	makeAnimatedLuaSprite('lantern','stages/lord_rabbit/RopryLayer4', -130, 0);
	addAnimationByPrefix('lantern','idle','RopryLayer4',24,true);
	objectPlayAnimation('lantern','idle',true);

	makeLuaSprite('light', 'stages/lord_rabbit/RopryLayer5', 0, 0);

	makeLuaSprite('curtain', 'stages/lord_rabbit/RopryLayer6', 0, 0);

	makeAnimatedLuaSprite('guest4','stages/lord_rabbit/RopryGuest/RopryGuest4', -15, 1275);
	addAnimationByPrefix('guest4','idle','Ropry_Guest4',24,false);

	addLuaSprite('sky', false);
	addLuaSprite('bg', false);
	addLuaSprite('window', false);
	addLuaSprite('guest0', false);
	addLuaSprite('guest1', false);
	addLuaSprite('guest2', false);
	addLuaSprite('guest3', false);
	addLuaSprite('rabbit', false);
	addLuaSprite('lantern', true);
	addLuaSprite('light', true);
	addLuaSprite('curtain', true);
	addLuaSprite('guest4', true);
end

function onBeatHit()
	-- triggered 4 times per section
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);
	objectPlayAnimation('guest3','idle',true);
	objectPlayAnimation('guest4','idle',true);
end