local musthit = false
local startUI = true
local hpBarPerc
local HeatLvl = 1
local GG = false

function onCreatePost()
	makeLuaSprite('BarBG', 'empty', 400,947)
	makeGraphic('BarBG', 472,54, '000000')
	setObjectCamera('BarBG', 'camHUD')
	setObjectOrder('BarBG', getObjectOrder('notes')-1)
	addLuaSprite('BarBG', true)

	makeLuaSprite('Bar', 'empty', 400,947)
	makeGraphic('Bar', 472,54, 'ff0077')
	setObjectCamera('Bar', 'camHUD')
	setObjectOrder('Bar', getObjectOrder('notes')-1)
	addLuaSprite('Bar', true)
--新的血条

	makeLuaSprite('HeatUIBG', 'mechanism/Kris/HeatUIBG', 0, 700)
	setObjectCamera('HeatUIBG', 'camHUD')
	setObjectOrder('HeatUIBG', getObjectOrder('notes')-1)
	scaleObject('HeatUIBG', 1, 1);
	addLuaSprite('HeatUIBG', true)

	makeAnimatedLuaSprite('HeatUI','mechanism/Kris/HeatUI', 926, 700)
	addAnimationByPrefix('HeatUI','Lvl1','Lvl1',24,false)
	addAnimationByPrefix('HeatUI','Lvl2','Lvl2',24,false)
	addAnimationByPrefix('HeatUI','Lvl3','Lvl3',24,false)
	addAnimationByPrefix('HeatUI','Lvl4','Lvl4',24,false)
	addAnimationByPrefix('HeatUI','Lvl5','Lvl5',24,false)
	addAnimationByPrefix('HeatUI','Lvl6','Lvl6',24,true)
	objectPlayAnimation('HeatUI','Lvl1',true)
	setObjectCamera('HeatUI', 'camHUD')
	setObjectOrder('HeatUI', getObjectOrder('notes')-1)
	scaleObject('HeatUI', 1, 1)
	addLuaSprite('HeatUI', true)
--创建UI贴图素材

	makeAnimatedLuaSprite('icon01', 'mechanism/Kris/BFicon', 90, 525)
	addAnimationByPrefix('icon01', 'normal', 'normal', 24, false)
	addAnimationByPrefix('icon01', 'danger', 'danger', 24, false)
	objectPlayAnimation('icon02','normal',true)
	setObjectCamera('icon01', 'camHUD')
	setObjectOrder('icon01', getObjectOrder('notes')-1)
	addLuaSprite('icon01', true)
	setProperty('icon01.alpha',0)

	makeAnimatedLuaSprite('icon02', 'mechanism/Kris/KRISicon', 90, 525)
	addAnimationByPrefix('icon02', 'normal', 'normal', 24, false)
	addAnimationByPrefix('icon02', 'danger', 'danger', 24, false)
	objectPlayAnimation('icon02','normal',true)
	setObjectCamera('icon02', 'camHUD')
	setObjectOrder('icon02', getObjectOrder('notes')-1)
	addLuaSprite('icon02', true)
	setProperty('icon02.alpha',0)
--新的小图标

	makeAnimatedLuaSprite('press_space', 'mechanism/Common/press_space', 535, 430);
	addAnimationByPrefix('press_space', 'press_space', 'press_space',36, true);
	scaleObject('press_space',0.75, 0.75)
	addLuaSprite('press_space', true);
	setObjectCamera('press_space','camHUD')
	objectPlayAnimation('press_space', 'press_space', true)
--按空格提示

	makeAnimatedLuaSprite('fly bf','mechanism/Kris/fly bf', 620, 400);
	addAnimationByPrefix('fly bf','fly bf','fly bf',24,false);
	objectPlayAnimation('fly bf','fly bf',true);
	scaleObject('fly bf', 1.6, 1.6);

	makeAnimatedLuaSprite('death_firework','mechanism/Kris/death_firework', 705, -535);
	addAnimationByPrefix('death_firework','death_firework','death_firework',24,false);
	objectPlayAnimation('death_firework','death_firework',true);
--机制失败演出动画

end

function onStepHit()
	if curStep == 1440 then
		OMGbomb()
		startUI = true
	end

	if curStep == 1450 then
		doTweenAlpha('showicon1', 'icon01', 1, 0.2)
		doTweenAlpha('showicon2', 'icon02', 1, 0.2)
	end

end

function OMGbomb()
	doTweenY('GoUI1', 'HeatUIBG', 340, 0.5)
	doTweenY('GoUI2', 'HeatUI', 340, 0.5)
	doTweenY('GoUI3', 'BarBG', 587, 0.5)
	doTweenY('GoUI4', 'Bar', 587, 0.5)
	--UI上移
	runTimer('heating', 3, 1)
	--开始计量条增长计时
end

function onTimerCompleted(tag)
	if tag == 'heating' then
		if HeatLvl < 6 then
			HeatLvl = HeatLvl + 1
			objectPlayAnimation('HeatUI','Lvl'..HeatLvl,true)
		--计量条增长一格
			runTimer('heating', 3, 1)
		--进行下一次增长计时
		end
		if HeatLvl == 6 then
			objectPlayAnimation('HeatUI','Lvl6',true)
		--计量条增长至第六格
			playSound("firework_fire",1, "firework_fire")
		--播放引线点燃音效
			runTimer('explosion', 3, 1)
		--开始爆炸倒计时
		end
	end

	if tag == 'explosion' and HeatLvl == 6 and curStep < 2464 then
		Kaboom()
	end
end

function Kaboom()
	GG = true
	soundFadeOut("firework_fire",2,0)
	cameraShake('camGame', 0.002, 1.5)
	cameraShake('camHUD', 0.002, 3)

	doTweenAlpha('showicon1', 'icon01', 0, 0.2)
	doTweenAlpha('showicon2', 'icon02', 0, 0.2)
	doTweenY('GoUI1', 'HeatUIBG', 700, 0.5)
	doTweenY('GoUI2', 'HeatUI', 700, 0.5)
	doTweenY('GoUI3', 'BarBG', 947, 0.5)
	doTweenY('GoUI4', 'Bar', 947, 0.5)

	setProperty('isCameraOnForcedPos',true)
	setProperty('cameraSpeed',.8)
	doTweenY('GG01', 'camFollow', -200, 0.2,'linear')
	doTweenY('GG02', 'moon', -1150, 1.25,'quadOut')
--机制失败演出镜头效果
end

function onTweenCompleted( tag )
	if tag == 'GG02' then
		addLuaSprite('fly bf', true)
		doTweenY('hellllp', 'fly bf', -600, 2,'quadOut')
		doTweenX('wheeee1', 'fly bf.scale', 0.5, 3, 'quadOut')
		doTweenY('wheeee2', 'fly bf.scale', 0.5, 3, 'quadOut')
		playSound("firework_fly",0.7, "firework_fly")
		--BF被放飞的动画和音效
	end
	if tag == 'wheeee2' then
		stopSound("firework_fly")
		playSound("firework_boom",1)

		cameraShake('camGame', 0.005, 0.1)
		setProperty('fly bf.visible',false)
		addLuaSprite('death_firework', true)
		--烟花爆炸的动画和音效（BF放飞的音效"firework_fly"重复播放，没能成功去除）
	end
--机制失败演出动画效果
end

function onUpdate()
	hpBarPerc = getProperty('health') / 2

	if hpBarPerc > 0.1 or hpBarPerc == 0.1 then
		setGraphicSize('Bar',getProperty('BarBG.width') * (hpBarPerc - hpBarPerc % 0.1),54)
	end
	setProperty('Bar.x',getProperty('BarBG.x') + 475 - getProperty('Bar.width'))
	--以上为血条控制相关，下面为小图标控制相关

	if startUI == true then
		setProperty('icon01.scale.x',getProperty('iconP1.scale.x'))
		setProperty('icon01.scale.y',getProperty('iconP1.scale.y'))
		setProperty('icon02.scale.x',getProperty('iconP2.scale.x'))
		setProperty('icon02.scale.y',getProperty('iconP2.scale.y'))
	--小图标跳动

			if getProperty('health') <= 0.4 then
				objectPlayAnimation('icon01', 'danger')
			end
			if getProperty('health') > 0.4 and getProperty('health') < 1.6 then
				objectPlayAnimation('icon01', 'normal')
				objectPlayAnimation('icon02', 'normal')
			end
			if getProperty('health') >= 1.6 then
				objectPlayAnimation('icon02', 'danger')
			end
			--小图标状态显示

			if not musthit == mustHitSection then
				setProperty('icon01.visible',false)
				setProperty('icon02.visible',true)
			if mustHitSection then
				setProperty('icon01.visible',true)
				setProperty('icon02.visible',false)
			end
			--镜头给到谁显示谁小图标
		end
	end
	musthit = mustHitSection
	--以上为小图标控制相关，下面为机制控制相关

	if HeatLvl >= 5 and GG == false then
		setProperty('press_space.visible',true)
	else
		setProperty('press_space.visible',false)
	--计量条大于等于5格时,显示按空格提示
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and HeatLvl >= 5 then
		HeatLvl = 1
		objectPlayAnimation('HeatUI','Lvl1',true)
		playSound("firework_cool",1)
	--计量条大于等于5格时,按空格重置计量条，并播放冷却音效
		stopSound("firework_fire")
	--如果有引线点燃音效，则停止播放
	end

	if getProperty('cpuControlled') == true and HeatLvl >= 5 then
		HeatLvl = 1
		objectPlayAnimation('HeatUI','Lvl1',true)
		playSound("firework_cool",1)
	--Botplay情况下，计量条大于等于5格时自动重置，并播放冷却音效
		stopSound("firework_fire")
	--如果有引线点燃音效，则停止播放
	end
	--以上为机制控制相关，下面为失败演出动画相关

	if GG == true then
		setProperty('press_space.visible',false)

		for i = 0,getProperty('notes.length')-1 do
			setPropertyFromGroup('notes', i, 'ignoreNote', true)
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
			setPropertyFromGroup('opponentStrums', i, 'alpha', 0.2)
			setPropertyFromGroup('playerStrums', i, 'alpha', 0.2)
		--让玩家无需按箭头，避免在演出结束前死亡（没能解决人声静音的问题，大概要改源码）
		end
	end

	if getProperty('death_firework.animation.curAnim.finished') then
		setProperty('health', -1)
		setProperty('camFollow.x', 0)
		setProperty('camFollow.y',0)
		--干掉玩家并把镜头给到BF死亡动画（镜头移动未起效，或许要改数值？）
	end
end