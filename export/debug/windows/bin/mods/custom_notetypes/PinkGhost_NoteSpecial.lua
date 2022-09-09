
local noteName = 'PinkGhost_NoteSpecial'
local filePath = 'notes/PinkGhost/PinkGhost_NoteSpecial'

----------------------------
--Custom splash sht
local hit0 = 0
local hit1 = 0
local hit2 = 0
local hit3 = 0

local offset0X = -43
local offset0Y = -60

local offset1X = -35
local offset1Y = -60

local offset2X = -43
local offset2Y = -60
 
local offset3X = -40
local offset3Y = -60

local noteSplashScale = 1
------------------------------


function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
		end
	end
	--debugPrint('Script started!')
end


function onCreatePost( ... )
	--createNoteSplash()
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then

	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
	
	end
end




function createNoteSplash( ... )
	--left 0, purple
	makeAnimatedLuaSprite('RednoteSplashes_0', filePath, defaultPlayerStrumX0 + offset0X,defaultPlayerStrumY0 + offset0Y)
	addAnimationByPrefix('RednoteSplashes_0', 'splash1', 'note splash purple 1', 36, false)
	addAnimationByPrefix('RednoteSplashes_0', 'splash2', 'note splash purple 2', 36, false)
	setScrollFactor('RednoteSplashes_0', 0, 0);
	scaleObject('RednoteSplashes_0',noteSplashScale, noteSplashScale);
	addLuaSprite('RednoteSplashes_0', true);
	setObjectCamera('RednoteSplashes_0','HUD')
	doTweenAlpha("RednoteSplashes_0A","RednoteSplashes_0",0,.0001)

	--down 1, blue
	makeAnimatedLuaSprite('RednoteSplashes_1', filePath, defaultPlayerStrumX1 + offset1X,defaultPlayerStrumY1 + offset1Y)
	addAnimationByPrefix('RednoteSplashes_1', 'splash1', 'note splash blue 1', 36, false)
	addAnimationByPrefix('RednoteSplashes_1', 'splash2', 'note splash blue 2', 36, false)
	setScrollFactor('RednoteSplashes_1', 0, 0);
	scaleObject('RednoteSplashes_1', noteSplashScale, noteSplashScale);
	addLuaSprite('RednoteSplashes_1', true);
	setObjectCamera('RednoteSplashes_1','HUD')
	doTweenAlpha("RednoteSplashes_1A","RednoteSplashes_1",0,.0001)
	--up 2, green
	makeAnimatedLuaSprite('RednoteSplashes_2',filePath, defaultPlayerStrumX2 + offset2X,defaultPlayerStrumY2 + offset2Y)
	addAnimationByPrefix('RednoteSplashes_2', 'splash1', 'note splash green 1', 36, false)
	addAnimationByPrefix('RednoteSplashes_2', 'splash2', 'note splash green 2', 36, false)
	setScrollFactor('RednoteSplashes_2', 0, 0);
	scaleObject('RednoteSplashes_2', noteSplashScale, noteSplashScale);
	addLuaSprite('RednoteSplashes_2', true);
	setObjectCamera('RednoteSplashes_2','HUD')
	doTweenAlpha("RednoteSplashes_2A","RednoteSplashes_2",0,.0001)

	--right 3, red
	makeAnimatedLuaSprite('RednoteSplashes_3',filePath, defaultPlayerStrumX3 + offset3X,defaultPlayerStrumY3 + offset3Y)
	addAnimationByPrefix('RednoteSplashes_3', 'splash1', 'note splash red 1', 36, false)
	addAnimationByPrefix('RednoteSplashes_3', 'splash2', 'note splash red 2', 36, false)
	setScrollFactor('RednoteSplashes_3', 0, 0);
	scaleObject('RednoteSplashes_3', noteSplashScale, noteSplashScale);
	addLuaSprite('RednoteSplashes_3', true);
	setObjectCamera('RednoteSplashes_3','HUD')
	doTweenAlpha("RednoteSplashes_3A","RednoteSplashes_3",0,.0001)
end

function playSplash(noteIndex)
	animIndex = 1

	if noteIndex == 0 then
	hit0 = hit0+1
	animIndex = hit0%2+1

	elseif noteIndex == 1 then
	hit1 = hit1+1
	animIndex = hit1%2+1

	elseif noteIndex == 2 then
	hit2 = hit2+1
	animIndex = hit2%2+1

	elseif noteIndex == 3 then
	hit3 = hit3+1
	animIndex = hit3%2+1
	end
	
	doTweenAlpha('RednoteSplashes_'..noteIndex..A,'RednoteSplashes_'..noteIndex,1,.0001)
	objectPlayAnimation('RednoteSplashes_'..noteIndex, 'splash'..animIndex, true)
end