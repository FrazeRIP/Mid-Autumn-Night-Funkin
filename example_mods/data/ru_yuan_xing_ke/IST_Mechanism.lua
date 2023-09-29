local secPerBeat = 0

local ISX = 0
local BFX = 410

local offset = 870

local width = 650

local isFlashing = false


local healthbarY = 0
local healthbarBG2Y = 0
local iconY = 0

local isDrainHealth = false

local lol = false

function onCreate( ... )
	
	makeAnimatedLuaSprite('SpeedLine', 'mechanism/IST/SpeedLine', 0, 0);
	addAnimationByPrefix('SpeedLine', 'SpeedLine', 'SpeedLine',18, true);
	addLuaSprite('SpeedLine', false);
	setObjectCamera('SpeedLine','camHUD')
	objectPlayAnimation('SpeedLine', 'SpeedLine', true)
	doTweenAlpha("SpeedLineA","SpeedLine",0,0.00001,'cubeOut')
	
	makeLuaSprite('halfWhiteFrame', 'common/whiteFrame', 0, 0);
	setObjectCamera('halfWhiteFrame','camOther')
	doTweenColor('halfWhiteFrameC','halfWhiteFrame','FFFFFF',.00001)
	doTweenAlpha("halfWhiteFrameOK","halfWhiteFrame",0,0.00001,'cubeOut')
	setBlendMode('halfWhiteFrame', 'add')
	addLuaSprite('halfWhiteFrame')

	makeLuaSprite('blackTop', '', 0, width)
	makeGraphic('blackTop', 1920, 720, '000000')
	--setGraphicSize('blackTop', 1920, 500)
	setScrollFactor('blackTop', 0, 0)
	setProperty('blackTop.alpha', 1)
	setObjectCamera('blackTop','hud')
    addLuaSprite('blackTop', false)
	
	
	makeLuaSprite('blackButtom', '', 0,-width)
	makeGraphic('blackButtom', 1920, 720, '000000')
	--setGraphicSize('blackButtom', 1920, 500)
	setScrollFactor('blackButtom', 0, 0)
	setProperty('blackButtom.alpha', 1)
	setObjectCamera('blackButtom','hud')
    addLuaSprite('blackButtom', false)

	
	makeAnimatedLuaSprite('press_space', 'mechanism/Common/press_space', 520, 530);
	addAnimationByPrefix('press_space', 'press_space', 'press_space',36, true);
	scaleObject('press_space',.85, .85)
	addLuaSprite('press_space', true);
	setObjectCamera('press_space','camHUD')
	objectPlayAnimation('press_space', 'press_space', true)
	doTweenAlpha("press_spaceA","press_space",0,0.00001,'cubeOut')
	
	Hide(0.0001,'cubeOut')
end

function Hide(duration,tween)
	doTweenY('top-Show','blackTop',720,duration,tween)
	doTweenY('down-Show','blackButtom',-720,duration,tween)
end

function Show(duration,tween)
	doTweenY('top-Show','blackTop',width,duration,tween)
	doTweenY('down-Show','blackButtom',-width,duration,tween)
end

function onUpdate(elapsed)
	-- body
	if isDrainHealth then

		if not botPlay then
			health = getProperty('health')
			setProperty('health', health- elapsed*0.3)
		else
			lol = not lol
			health = getProperty('health')
			if lol then
				setProperty('health', 1.01)
			else
				setProperty('health', 0.99)
			end
		end
		
		if not botPlay then
			local isSpacePressed = keyJustPressed('space')
			if isSpacePressed then
				health = getProperty('health')
				setProperty('health', health +0.05)
			end
		end
	end
	
end


function onCreatePost()
	secPerBeat = 60/curBpm

	makeAnimatedLuaSprite('BF_Focus', 'mechanism/IST/BF_Focus', BFX+offset, 420);
	addAnimationByPrefix('BF_Focus', 'Exit', 'Exit', 24, false);
	addAnimationByPrefix('BF_Focus', 'Idle', 'Idle', 24, true);
	addLuaSprite('BF_Focus', false);
	setObjectCamera('BF_Focus','hud')
	objectPlayAnimation('BF_Focus', 'Idle', true)
	setProperty('BF_Focus.visible',false)

	makeAnimatedLuaSprite('IS_Focus', 'mechanism/IST/IS_Focus', ISX-offset, 100);
	addAnimationByPrefix('IS_Focus', 'Exit', 'Exit', 24, false);
	addAnimationByPrefix('IS_Focus', 'Idle', 'Idle', 24, true);
	addLuaSprite('IS_Focus', false);
	setObjectCamera('IS_Focus','hud')
	objectPlayAnimation('IS_Focus', 'Idle', true)
	setProperty('IS_Focus.visible',false)

	makeAnimatedLuaSprite('Begin', 'mechanism/IST/Begin', 330, 200);
	addAnimationByPrefix('Begin', 'Begin', 'Begin',18, false);
	addLuaSprite('Begin', false);
	setObjectCamera('Begin','hud')
	objectPlayAnimation('Begin', 'Begin', true)
	setProperty('Begin.visible',false)

	makeLuaSprite('solidF', '', 0, 0);
	makeGraphic('solidF', '1280','720', 'FFFFFF')
	addLuaSprite('solidF',true)
	setObjectCamera('solidF','camOther')
	doTweenAlpha("solidFA","solidF",0.0,0.00001,'cubeOut')


	healthbarY= getProperty('healthBar.y')
	healthbarBG2Y = getProperty('healthBarBG2.y')
	iconY = getProperty('iconP1.y')

end

function onBeatHit( ... )
	if curBeat == 150 then
		cameraFlash('camGame','FFFFFF',secPerBeat)
		popOut()
	end

	if curBeat == 248 then
		cameraFlash('camHUD','FFFFFF',secPerBeat*2)	

	    for i = 0,7 do
			noteTweenAlpha('NoteA'..i, i, 0, secPerBeat*2, 'cubeOut')
		end
		
		setProperty('scoreTxt.alpha', 0)
		setProperty('healthBar.y',360)
		setProperty('healthBarBG2.y',344)
		setProperty('iconP1.y',290)
		setProperty('iconP2.y',290)

		objectPlayAnimation('BF_Focus', 'Idle', true)
		objectPlayAnimation('IS_Focus', 'Idle', true)
		doTweenX('BF_FocusX1', 'BF_Focus', BFX+offset, 0.0001, 'quadOut')
		doTweenX('IS_FocusX1', 'IS_Focus', ISX-offset, 0.0001, 'quadOut')

		doTweenX('BF_FocusX2', 'BF_Focus', BFX, secPerBeat*1.5, 'cubeOut')
		doTweenX('IS_FocusX2', 'IS_Focus', ISX, secPerBeat*1.5, 'cubeOut')

		doTweenAlpha("press_spaceA","press_space",1,0.00001,'cubeOut')

		isDrainHealth = true;
		setProperty('health', 1.01)
	end

	if curBeat == 278 then
		doTweenAlpha("solidFA","solidF",1.0,secPerBeat*2)
	end

	if curBeat == 281 then
		isDrainHealth = false;
		isFlashing = false;
		setProperty('healthBar.y',healthbarY)
		setProperty('healthBarBG2.y',healthbarBG2Y)
		setProperty('iconP1.y',iconY)
		setProperty('iconP2.y',iconY)
		doTweenX('BF_FocusX1', 'BF_Focus', BFX+offset, 0.0001, 'quadOut')
		doTweenX('IS_FocusX1', 'IS_Focus', ISX-offset, 0.0001, 'quadOut')
		doTweenAlpha("press_spaceA","press_space",0,0.00001,'cubeOut')
		doTweenAlpha("solidFA","solidF",0,secPerBeat*2)
		Hide(0.0001,'cubeOut')
		setProperty('scoreTxt.alpha',1)
		doTweenAlpha("SpeedLineA","SpeedLine",0,0.00001,'cubeOut')
		
	    for i = 0,7 do
			noteTweenAlpha('NoteA'..i, i, 1, secPerBeat*2, 'cubeOut')
		end
	end
end

function onStepHit( ... )
	if curStep == 608 then
		isFlashing = true
	end

	if isFlashing then
		if curStep % 2 == 0 then
			doTweenAlpha("halfWhiteFrameOK1","halfWhiteFrame",0.2,0.00001,'cubeOut')
			doTweenAlpha("halfWhiteFrameOK2","halfWhiteFrame",0.,secPerBeat*.45,'cubeIn')
		end
	end

	if curStep == 848 then
		isFlashing = false
		doTweenAlpha("SpeedLineA","SpeedLine",0.0,0.00001,'cubeOut')
	end

	if curStep == 864 then
		isFlashing = true
		doTweenAlpha("SpeedLineA","SpeedLine",0.3,0.00001,'cubeOut')
	end
end



function popOut( ... )
	setProperty('BF_Focus.visible',true)
	setProperty('IS_Focus.visible',true)
	setProperty('Begin.visible',true)

	objectPlayAnimation('BF_Focus', 'Idle', true)
	objectPlayAnimation('IS_Focus', 'Idle', true)
	doTweenX('BF_FocusX1', 'BF_Focus', BFX+offset, 0.0001, 'quadOut')
	doTweenX('IS_FocusX1', 'IS_Focus', ISX-offset, 0.0001, 'quadOut')

	doTweenX('BF_FocusX2', 'BF_Focus', BFX, secPerBeat*1.5, 'cubeOut')
	doTweenX('IS_FocusX2', 'IS_Focus', ISX, secPerBeat*1.5, 'cubeOut')
	runTimer('FocusExit',secPerBeat*2)
	runTimer('Beginnn',secPerBeat*.5)

	Show('4','cubeOut')
	playSound('court_start',.7)
	doTweenAlpha("SpeedLineA","SpeedLine",0.4,0.00001,'cubeOut')
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'FocusExit' then
		objectPlayAnimation('BF_Focus', 'Exit', true)
		objectPlayAnimation('IS_Focus', 'Exit', true)
	end
	if tag == 'Beginnn' then
		objectPlayAnimation('Begin', 'Begin', true)
	end
end




function Hide(duration,tween)
	doTweenY('top-Show','blackTop',720,duration,tween)
	doTweenY('down-Show','blackButtom',-720,duration,tween)
	doTweenColor('bgBrightA', 'A', 'FFFFFF', duration,tween)
	doTweenColor('bgBrightC', 'C', 'FFFFFF', duration,tween)
end

function Show(duration,tween)
	doTweenY('top-Show','blackTop',width,duration,tween)
	doTweenY('down-Show','blackButtom',-width,duration,tween)
	doTweenColor('bgDarkA', 'A', '9C9C9C', duration,tween)
	doTweenColor('bgDarkC', 'C', '9C9C9C', duration,tween)
end