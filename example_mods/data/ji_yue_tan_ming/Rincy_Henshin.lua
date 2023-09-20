

function onCreate( ... )
	addCharacterToList('RincyB', 'dad')
end

function onUpdate( elapsed)
	secPerBeat = 60/curBpm
end

function onCreatePost( ... )
	makeAnimatedLuaSprite('RincyHenshin', 'mechanism/Rincy/RincyHenshin', defaultOpponentX-210, defaultOpponentY-20);
	addAnimationByPrefix('RincyHenshin','RincyHenshinA','RincyHenshinA',24,false);
	addAnimationByPrefix('RincyHenshin','RincyHenshinB','RincyHenshinB',24,false);
	objectPlayAnimation('RincyHenshin', 'RincyHenshinB',true)
	scaleObject('RincyHenshin', .6, .6);
	addLuaSprite('RincyHenshin', false);
	doTweenAlpha("RincyHenshinA","RincyHenshin",0,0.00001,'cubeOut')
end



function onBeatHit( ... )
	if curBeat == 116 then
		playSound('rc_transformation',1)
		setProperty('dad.visible', 'false')
		doTweenAlpha("RincyHenshinA","RincyHenshin",1,0.00001,'cubeOut')
		objectPlayAnimation('RincyHenshin', 'RincyHenshinA',true)
		doTweenY('RincyHenshinY', 'RincyHenshin', defaultOpponentY -60 , secPerBeat*4, 'quadIn')
	end

	if curBeat == 118 then
		objectPlayAnimation('RincyHenshin', 'RincyHenshinB',true)
	end

	if curBeat == 120 then
		setProperty('dad.visible', 'true')
		triggerEvent('Change Character','dad','RincyB')
		doTweenAlpha("boyfriendA","boyfriend",1,0.00001,'cubeOut')
		doTweenAlpha("RincyHenshinA","RincyHenshin",0,0.00001,'cubeOut')
		triggerEvent('Manage Cam Dir Properties','0,50','opponent')
	end
end
