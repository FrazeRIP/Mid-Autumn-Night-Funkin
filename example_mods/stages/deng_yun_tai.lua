
local Xoffset = -1450
local Yoffset = -1800
local ScaleOffset = 1.45

local secPerBeat

local shineAmount = .3

local okay = false

local lightSprites = {}
	
function onCreate()
	makeLuaSprite('PaolaLayer0', 'stages/deng_yun_tai/PaolaLayer0', 50 +Xoffset, 200 + Yoffset)
	setScrollFactor('PaolaLayer0', 1, 0.5);
	scaleObject('PaolaLayer0', ScaleOffset, ScaleOffset);

	makeLuaSprite('Shine', 'stages/deng_yun_tai/Shine', 50 +Xoffset, 200 + Yoffset)
	setScrollFactor('Shine', 1, 0.5);
	scaleObject('Shine', ScaleOffset, ScaleOffset);
	
	makeLuaSprite('cloud1', 'stages/deng_yun_tai/cloud1', 570 +Xoffset, 250 + Yoffset)
	setScrollFactor('cloud1', 1, 0.55);
	scaleObject('cloud1', ScaleOffset, ScaleOffset);

	makeLuaSprite('cloud2', 'stages/deng_yun_tai/cloud2', 1750 +Xoffset, 200 + Yoffset)
	setScrollFactor('cloud2', 1, 0.6);
	scaleObject('cloud2', ScaleOffset, ScaleOffset);


	makeLuaSprite('PaolaLayer1', 'stages/deng_yun_tai/PaolaLayer1', 0 +Xoffset, 125 + Yoffset)
	scaleObject('PaolaLayer1', ScaleOffset, ScaleOffset);
	setScrollFactor('PaolaLayer1',1, 0.7);


	makeLuaSprite('PaolaLayer2', 'stages/deng_yun_tai/PaolaLayer2',0 +Xoffset, 50 + Yoffset)
	scaleObject('PaolaLayer2', ScaleOffset, ScaleOffset);
	setScrollFactor('PaolaLayer2',1, 0.8);

	makeLuaSprite('PaolaLayer3', 'stages/deng_yun_tai/PaolaLayer3',0 +Xoffset, 0 + Yoffset)
	scaleObject('PaolaLayer3', ScaleOffset, ScaleOffset);
	setScrollFactor('PaolaLayer2', 1, 0.9);

	makeLuaSprite('PaolaLayer4', 'stages/deng_yun_tai/PaolaLayer4', 0 +Xoffset, 200 + Yoffset)
	scaleObject('PaolaLayer4', ScaleOffset, ScaleOffset);

	makeLuaSprite('PaolaLayer5', 'stages/deng_yun_tai/PaolaLayer5',0 +Xoffset, 200 + Yoffset)
	scaleObject('PaolaLayer5', ScaleOffset, ScaleOffset);

	makeAnimatedLuaSprite('guest0','stages/deng_yun_tai/Guest/PaolaGuest0', -1150 , -100 )
	scaleObject('guest0', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest0','idle','PaolaGuest0',24,false);
	
	makeAnimatedLuaSprite('guest1','stages/deng_yun_tai/Guest/PaolaGuest1', -1200 ,  -300 )
	scaleObject('guest1', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest1','idle','PaolaGuest1',24,false);
	
	makeAnimatedLuaSprite('guest2','stages/deng_yun_tai/Guest/PaolaGuest2',  1100 ,  -100   )
	scaleObject('guest2', ScaleOffset, ScaleOffset);
	addAnimationByPrefix('guest2','idle','PaolaGuest2',24,false);
	
	makeLuaSprite('halfWhiteFrame', 'common/halfWhiteFrame', 0, 0);
	setObjectCamera('halfWhiteFrame','camHUD')
	doTweenColor('halfWhiteFrameC','halfWhiteFrame','FFE0B4',.00001)
	doTweenAlpha("halfWhiteFrameOK","halfWhiteFrame",0,0.00001,'cubeOut')

	addLuaSprite('PaolaLayer0', false);
	addLuaSprite('Shine', false);
	
	addLuaSprite('cloud1', false);
	addLuaSprite('cloud2', false);

	addLuaSprite('PaolaLayer1', false);
	addLuaSprite('PaolaLayer2', false);
	addLuaSprite('guest1', false);
	addLuaSprite('PaolaLayer3', false);
	addLuaSprite('PaolaLayer4', false);
	addLuaSprite('PaolaLayer5', false);

	addLuaSprite('guest0', false);
	addLuaSprite('guest2', false);

	generateLightSprite('light1',645,-830 -5,3,1)
	generateLightSprite('light2',1045,-905 -5,3,1)
	generateLightSprite('light3',1425,-730  -5,3,1)
	
	generateLightSprite('light4',-645 -338,-830 -5,3,1)
	generateLightSprite('light5',-1045 -338,-905  -5,3,1)
	generateLightSprite('light6',-1425 -338,-730  -5,3,1)

	generateLightSprite('light7',241,-350,1.5,.9)
	generateLightSprite('light8',-174,-350,1.5,.9)
	generateLightSprite('light9',-174,-525,1.5,.9)
	generateLightSprite('light10',241,-525,1.5,.9)
	
	addLuaSprite('halfWhiteFrame', false);
end



function onCreatePost( ... )
	doTweenX('paolaSX', 'dad.scale', .9, .00001)
	doTweenY('paolaSY', 'dad.scale', .9, .00001)
	doTweenX('bfSX', 'boyfriend.scale', 1, .00001)
	doTweenY('bfSY', 'boyfriend.scale', 1,.00001)
	doTweenX('gfSX', 'gf.scale', .75, .00001)
	doTweenY('gfSY', 'gf.scale', .75, .00001)

	
	doTweenAlpha('cloud1A', 'cloud1', .6, 0.0001)
	doTweenAlpha('cloud2A', 'cloud2', .6, 0.0001)

	doTweenAlpha('ShineA1', 'Shine', 0, 1.5,"smoothStepInOut")
	
	secPerBeat = 60/curBpm
end



function onBeatHit()
	objectPlayAnimation('guest0','idle',true);
	objectPlayAnimation('guest1','idle',true);
	objectPlayAnimation('guest2','idle',true);

	if curBeat == 88 then
		shineAmount = 1
		okay = true
	end
	
	if curBeat == 188 then
		doTweenX('cloud1X', 'cloud1',  450 +Xoffset, .0001)
		doTweenX('cloud2X', 'cloud2', 1850 +Xoffset, .0001)

		doTweenX('cloud1Xv', 'cloud1', Xoffset +1500, 80)
		doTweenX('cloud2Xv', 'cloud2', Xoffset -550, 80)
	end

	if curBeat % 4 == 0 then
		for key,value in pairs(lightSprites) do 
			doTweenAlpha(value..'A1', value, shineAmount ,secPerBeat*2,'smoothStepIn')
		end
		
		if okay then
			doTweenAlpha("halfWhiteFrameA1","halfWhiteFrame",0.8,secPerBeat*2,'smoothStepIn')
		end
	end

end

function onCountdownStarted( ... )
	doTweenX('cloud1X', 'cloud1', Xoffset -1000, 50)
	doTweenX('cloud2X', 'cloud2', Xoffset +3000, 60)
end


function generateLightSprite(tag,x,y,size,scrollFactor)
	makeLuaSprite(tag, 'stages/deng_yun_tai/lightfunc', x , y )
	scaleObject(tag, size, size);
	setScrollFactor(tag, 1, scrollFactor);
	table.insert(lightSprites, tag)
	addLuaSprite(tag, false);
	doTweenAlpha(tag..'A', tag, 0, 0.0001)
end

function onTweenCompleted( tag )
	if tag == 'ShineA1' then
		doTweenAlpha('ShineA2', 'Shine', .7, 1.5,"smoothStepInOut")
	end
	
	if tag == 'ShineA2' then
		doTweenAlpha('ShineA1', 'Shine', 0, 1,"smoothStepInOut")
	end

	if tag == 'light1A1' then
		for key,value in pairs(lightSprites) do 
			doTweenAlpha(value..'A2', value, 0 ,secPerBeat*2,'smoothStepIn')
		end
	end

	if tag == 'halfWhiteFrameA1' then
		doTweenAlpha("halfWhiteFrameA2","halfWhiteFrame",0.3,secPerBeat*2,'smoothStepIn')
	end
	
	if tag == 'flashA1' then
		doTweenAlpha("flashA2", 'flash', 0,secPerBeat*4,'cubeOut')
	end
end
