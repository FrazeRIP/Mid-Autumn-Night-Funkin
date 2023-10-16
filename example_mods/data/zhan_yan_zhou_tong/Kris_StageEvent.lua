function onCreate()
	setProperty('skipCountdown',true)

	makeAnimatedLuaSprite('purple','mechanism/Kris/fireworks/purple', 100, -420);
	addAnimationByPrefix('purple','purple','purple',20,false);
	objectPlayAnimation('purple','purple',true);
	scaleObject('purple', 1, 1);

	makeAnimatedLuaSprite('blue','mechanism/Kris/fireworks/blue', 800, -500);
	addAnimationByPrefix('blue','blue','blue',20,false);
	objectPlayAnimation('blue','blue',true);
	scaleObject('blue', 1, 1);

	makeAnimatedLuaSprite('green','mechanism/Kris/fireworks/green', 275, -270);
	addAnimationByPrefix('green','green','green',20,false);
	objectPlayAnimation('green','green',true);
	scaleObject('green', 1, 1);

	makeAnimatedLuaSprite('red','mechanism/Kris/fireworks/red', 600, -400);
	addAnimationByPrefix('red','red','red',20,false);
	objectPlayAnimation('red','red',true);
	scaleObject('red', 1, 1);

--烟花

	makeAnimatedLuaSprite('speech_burn','mechanism/Kris/speech_burn', 60, 380);
	setObjectCamera('speech_burn', 'other')
	addAnimationByPrefix('speech_burn','Speech Bubble Open','Speech Bubble Open',24,false);
	addAnimationByPrefix('speech_burn','Speech Bubble Burn','Speech Bubble Burn',24,false);
	objectPlayAnimation('speech_burn','Speech Bubble Open',false);
	scaleObject('speech_burn', 0.9, 0.9);

	makeLuaText('Dialogues','Hey',1000,screenWidth/2 - 420,screenHeight/2 + 80);
	setTextSize('Dialogues',50);
	setTextAlignment('Dialogues','left'); 
	setTextColor('Dialogues', 'ffffff')
	setObjectCamera('Dialogues', 'other')
	setTextFont('Dialogues', 'ZhengDaoCuShuTi.ttf')

--伪对话

	makeLuaSprite('BlackBoard', 'empty', 0, -540)
	makeGraphic('BlackBoard', 1280, 1500, '000000')
	addLuaSprite('BlackBoard', true)

	makeLuaText('KrisSayEN','Come on Boyfriend,',1000,screenWidth/2 - 500,screenHeight/2 - 100);
	setTextSize('KrisSayEN',70);
	setTextColor('KrisSayEN', 'ffffff')
	setObjectCamera('KrisSayEN', 'other')
	setTextFont('KrisSayEN', 'ZhengDaoCuShuTi.ttf')
	addLuaText('KrisSayEN');
	setProperty('KrisSayEN.alpha',0)

	makeLuaText('KrisSayCN','来吧BF,',1000,screenWidth/2 - 500,screenHeight/2);
	setTextSize('KrisSayCN',70);
	setTextColor('KrisSayCN', 'ffffff')
	setObjectCamera('KrisSayCN', 'other')
	setTextFont('KrisSayCN', 'ZhengDaoCuShuTi.ttf')
	addLuaText('KrisSayCN');
	setProperty('KrisSayCN.alpha',0)

	setProperty('guest0.visible',false)
	setProperty('guest1.visible',false)
	setProperty('gf.visible',false)
	setProperty('boyfriend.visible',false)
	setProperty('dad.visible',false)
	setProperty('camHUD.alpha',0)

end

function onStepHit()
	if curStep == 31 then
		setProperty('BlackBoard.alpha',0.3)
		cameraFlash('camGame','FFFFFF',0.25)
		doTweenAlpha('Black1','BlackBoard',1,1,'linear')
	end

	if curStep == 63 then
		setProperty('BlackBoard.alpha',0.1)
		cameraFlash('camGame','FFFFFF',0.25)
		doTweenAlpha('Black1','BlackBoard',1,1,'linear')
		setProperty('guest0.visible',true)
		setProperty('guest1.visible',true)
		setProperty('gf.visible',true)
		setProperty('boyfriend.visible',true)
	end

	if curStep == 95 then
		setProperty('BlackBoard.alpha',0.1)
		cameraFlash('camGame','FFFFFF',0.25)
		doTweenAlpha('Black1','BlackBoard',0.4,1,'linear')

		setProperty('isCameraOnForcedPos',true)
		setProperty('cameraSpeed',.8)
		doTweenY('camFollowY', 'camFollow', -200, 0.2,'linear')
		doTweenY('moonY', 'moon', -1150, 1.25,'quadOut')
	end

	if curStep == 109 then
		doTweenAlpha('SayEN','KrisSayEN',1,0.2,'linear')
		doTweenAlpha('SayCN','KrisSayCN',1,0.2,'linear')
	end

	if curStep == 127 then
		setTextString('KrisSayEN','Come on Boyfriend, show me what you got.')
		setTextString('KrisSayCN','来吧BF，让我瞧瞧你的能耐。')
		doTweenAlpha("HUDAlpha","camHUD",1,0.2)
	end

	if curStep == 142 then
		setTextString('KrisSayEN','Don`t let me down.')
		setTextString('KrisSayCN','别让我失望哟。')
		doTweenAlpha('SayEN','KrisSayEN',0,1,'linear')
		doTweenAlpha('SayCN','KrisSayCN',0,1,'linear')
		doTweenAlpha('Black1','BlackBoard',0,1,'linear')
	end

	if curStep == 147 then
		makeLuaSprite('ready', 'ready', 210, 150)
		setObjectCamera('ready', 'hud')
		addLuaSprite('ready', true)
		doTweenAlpha('readyTween', 'ready', 0, crochet / 1000, cubeInOut)
	end

	if curStep == 151 then
		makeLuaSprite('set', 'set', 210, 150)
		setObjectCamera('set', 'hud')
		addLuaSprite('set', true)
		doTweenAlpha('setTween', 'set', 0, crochet / 1000, cubeInOut)
	end

	if curStep == 155 then
		setProperty('dad.visible',true)
		setProperty('isCameraOnForcedPos',false)
		doTweenY('moonY', 'moon', -900, 1.5,'quadOut')
		makeLuaSprite('go', 'go', 210, 150)
		setObjectCamera('go', 'hud')
		addLuaSprite('go', true)
		doTweenAlpha('goTween', 'go', 0, crochet / 1000, cubeInOut)
	end

	if curStep == 416 then
		cameraFlash('camGame','FFFFFF',0.4)
	end

	if curStep == 672 then
		cameraFlash('camGame','FFFFFF',0.4)
	end

	if curStep == 782 then
		doTweenAlpha('Black1','BlackBoard',0.4,1,'linear')
		setTextString('KrisSayEN','It`s going to be fast~')
		setTextString('KrisSayCN','要加速喽~')
		doTweenAlpha('SayEN','KrisSayEN',1,0.2,'linear')
		doTweenAlpha('SayCN','KrisSayCN',1,0.2,'linear')
	end

	if curStep == 799 then
		doTweenAlpha('SayEN','KrisSayEN',0,0.5,'linear')
		doTweenAlpha('SayCN','KrisSayCN',0,0.5,'linear')
		doTweenAlpha('Black1','BlackBoard',0,0.5,'linear')
	end

	if curStep == 1184 then
		cameraFlash('camGame','FFFFFF',0.4)
		setProperty('isCameraOnForcedPos',true)
		doTweenX('camFollowX', 'camFollow', 640, 0.2,'linear')
		doTweenY('camFollowY', 'camFollow', -200, 0.2,'linear')
		doTweenY('moonY', 'moon', -1150, 1.25,'quadOut')

		doTweenAlpha('HPbye0', 'healthBarBG2', 0, 0.2,'linear')
		doTweenAlpha('HPbye1', 'healthBarBG', 0, 0.2,'linear')
		doTweenAlpha('HPbye2', 'healthBar', 0, 0.2,'linear')
		doTweenAlpha('HPbye3', 'iconP1', 0, 0.2,'linear')
		doTweenAlpha('HPbye4', 'iconP2', 0, 0.2,'linear')
		--和原版血条说再见吧
	end


	if curStep == 1200 then
		addLuaSprite('purple', false)

		if downscroll then
			--doTweenY('timeBarBG','timeBarBG',44,3,'linear')
			doTweenY('timeBar','timeBar',44,3,'linear')
			doTweenY('timeTxt','timeTxt',30,3,'linear')
			doTweenY('fakeTimeBar','fakeTimeBar',44,3,'linear')
			doTweenY('timeFake','timeFake',30,3,'linear')
			for i =0,3 do
				setPropertyFromGroup('opponentStrums',i,'downScroll',false)
				setPropertyFromGroup('playerStrums',i,'downScroll',false)
				noteTweenY("opponentStrumsY"..i,i,60,3,'linear')
				noteTweenY("PlayerStrumsY"..i,i+4,60,3,'linear')
			end
		end
	end

	if curStep == 1208 then
		addLuaSprite('green', false)
	end

	if curStep == 1210 then
		addLuaSprite('red', false)
	end

	if curStep == 1220 then
		addLuaSprite('blue', false)
	end

	if curStep == 1374 then
		doTweenAlpha('Black1','BlackBoard',0.6,0.5,'linear')
		addLuaSprite('speech_burn', true)
	end

	if curStep == 1376 then
		addLuaText('Dialogues');
	end

	if curStep == 1379 then
		setTextString('Dialogues','Hey you')
	end

	if curStep == 1382 then
		setTextString('Dialogues','Hey you Boyfriend,')
	end

	if curStep == 1400 then
		setTextColor('Dialogues', '55c3ff')
		setTextString('Dialogues','Dah')
	end

	if curStep == 1412 then
		setTextColor('Dialogues', 'ffffff')
		setTextString('Dialogues','Don`t')
	end

	if curStep == 1418 then
		setTextString('Dialogues','Don`t Stop~~')
	end

	if curStep == 1421 then
		setTextString('Dialogues','Don`t Stoop~~')
	end

	if curStep == 1422 then
		setTextString('Dialogues','Don`t Stooop~~')
	end

	if curStep == 1423 then
		cameraShake('other', 0.01, 1.3)
		setTextString('Dialogues','Don`t Stoooop~~')
	end

	if curStep == 1424 then
		setTextString('Dialogues','Don`t Stooooop~~')
	end

	if curStep == 1425 then
		setTextString('Dialogues','Don`t Stoooooop~~')
	end

	if curStep == 1426 then
		setTextString('Dialogues','Don`t Stooooooop~~')
	end

	if curStep == 1427 then
		setTextString('Dialogues','Don`t Stoooooooop~~')
	end

	if curStep == 1440 then
		setProperty('isCameraOnForcedPos',false)
		doTweenY('moonY', 'moon', -900, 1.5,'quadOut')
		doTweenAlpha('Black1','BlackBoard',0,0.5,'linear')
		doTweenX('KrisMove', 'KrisDialogue', -350, 0.2)
		removeLuaText('Dialogues');
		objectPlayAnimation('speech_burn','Speech Bubble Burn',false);
		doTweenX('wowX', 'speech_burn.scale', 1.1, 0.1)
		doTweenY('wowY', 'speech_burn.scale', 1.1, 0.1)
	end

end

function onUpdate()
	if getProperty('purple.animation.curAnim.finished') then
		if curStep >= 1423 then
			removeLuaSprite('purple')
		else
			setProperty('purple.x', math.random(100, 800))
			setProperty('purple.y', math.random(-270, -500))
			objectPlayAnimation('purple','purple',true)
		end
	end

	if getProperty('blue.animation.curAnim.finished') then
		if curStep >= 1423 then
			removeLuaSprite('blue')
		else
			setProperty('blue.x', math.random(100, 800))
			setProperty('blue.y', math.random(-270, -500))
			objectPlayAnimation('blue','blue',true)
		end
	end

	if getProperty('green.animation.curAnim.finished') then
		if curStep >= 1423 then
			removeLuaSprite('green')
		else
			setProperty('green.x', math.random(100, 800))
			setProperty('green.y', math.random(-270, -500))
			objectPlayAnimation('green','green',true)
		end
	end

	if getProperty('red.animation.curAnim.finished') then
		if curStep >= 1423 then
			removeLuaSprite('red')
		else
			setProperty('red.x', math.random(100, 800))
			setProperty('red.y', math.random(-270, -500))
			objectPlayAnimation('red','red',true)
		end
	end

--每个烟花播放完一次动画后随机改变位置

end

--function onCreatePost()
--end