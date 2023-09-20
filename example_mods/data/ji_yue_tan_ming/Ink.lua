local secPerBeat=0

function onCreatePost( ... )

	makeLuaSprite('inkBG','mechanism/Rincy/Ink/inkBG', -1000,-150);
	doTweenAlpha("inkBGA","inkBG",0, 0.0001)
	scaleObject('inkBG', 1.5, 1.5);
	addLuaSprite('inkBG', false);

	
	makeLuaSprite('whiteFade','mechanism/Rincy/Ink/whiteFade', -1000,-150);
	doTweenAlpha("whiteFadeA","whiteFade",0, 0.0001)
	scaleObject('whiteFade', 2, 1.5);
	addLuaSprite('whiteFade', false);
	
	makeLuaSprite('inkTitle','mechanism/Rincy/Ink/inkTitle', 1150,10);
	doTweenAlpha("inkTitleA","inkTitle",0, 0.0001)
	setObjectCamera('inkTitle','camOther')
	addLuaSprite('inkTitle', false);
	
	makeLuaSprite('inkStamp','mechanism/Rincy/Ink/inkStamp', 1175,270);
	doTweenAlpha("inkStampA","inkStamp",0, 0.0001)
	setObjectCamera('inkStamp','camOther')
	addLuaSprite('inkStamp', false);
	
	local offset = 35
	for i = 1,11 do
		makeLuaSprite('inkText'..tostring(i),'mechanism/Rincy/Ink/'..'inkText'..tostring(i), 1100 - offset*i,50);
		setObjectCamera('inkText'..tostring(i),'camOther')
		addLuaSprite('inkText'..tostring(i), false);
		doTweenAlpha('inkText'..tostring(i)..'A','inkText'..tostring(i),0, 0.0001)
	end
end

function onBeatHit( ... )
	if curBeat == 232 then
		doTweenAlpha("inkBGA","inkBG",1, secPerBeat*4,'cubeOut')
		doTweenAlpha("whiteFadeA","whiteFade",1,  0.0001,'cubeOut')
		doTweenX('inkBGX', 'inkBG', -700,secPerBeat*32*4)
	end

	if curBeat == 234 then
		doTweenAlpha("inkTitleA","inkTitle",1, secPerBeat*3.8)
	end

	if curBeat == 238 then
		doTweenAlpha('inkText1A','inkText1',1, secPerBeat*3.8)
	end

	if curBeat == 242 then
		doTweenAlpha('inkText2A','inkText2',1, secPerBeat*3.8)
	end

	if curBeat == 246 then
		doTweenAlpha('inkText3A','inkText3',1, secPerBeat*3.8)
	end
	
	if curBeat == 250 then
		doTweenAlpha('inkText4A','inkText4',1, secPerBeat*3.8)
	end

	if curBeat == 254 then
		doTweenAlpha('inkText5A','inkText5',1, secPerBeat*3.8)
	end

	if curBeat == 258 then
		doTweenAlpha('inkText6A','inkText6',1, secPerBeat*3.8)
	end

	if curBeat == 262 then
		doTweenAlpha('inkText7A','inkText7',1, secPerBeat*3.8)
	end

	if curBeat == 266 then
		doTweenAlpha('inkText8A','inkText8',1, secPerBeat*3.8)
	end

	if curBeat == 270 then
		doTweenAlpha('inkText9A','inkText9',1, secPerBeat*3.8)
	end

	if curBeat == 274 then
		doTweenAlpha('inkText10A','inkText10',1, secPerBeat*3.8)
	end

	if curBeat == 278 then
		doTweenAlpha('inkText11A','inkText11',1, secPerBeat*3.8)
	end

	if curBeat == 282 then
		doTweenAlpha("inkStampA","inkStamp",1, secPerBeat*8,'cubeOut')
	end

	if curBeat == 292 then
		for i = 1,11 do
			doTweenAlpha('inkText'..tostring(i)..'A','inkText'..tostring(i),0, secPerBeat*4,'cubeOut')
			doTweenAlpha("inkStampA","inkStamp",0, secPerBeat*4,'cubeOut')
			doTweenAlpha("inkTitleA","inkTitle",0, secPerBeat*4,'cubeOut')
		end
	end
	
	if curBeat == 296 then
		doTweenAlpha("inkBGA","inkBG",0, secPerBeat*32, 'quadIn')
		doTweenAlpha("whiteFadeA","whiteFade",0, secPerBeat*32, 'quadIn')
	end
end

function onUpdate( elapsed)
	secPerBeat = 60/curBpm
end