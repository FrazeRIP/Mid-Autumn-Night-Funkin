
local noteName = 'Sarah_NoteSpecial'

local noteX0
local noteX1
local noteX2
local noteX3


local secPerBeat=0

function onCreatePost( ... )
	
	makeAnimatedLuaSprite('center_Note_Static', 'notes/Sarah/Sarah_NoteSpecial', 0, 0);
	addAnimationByPrefix('center_Note_Static','arrow static','arrow static',24,false);
	objectPlayAnimation('center_Note_Static', 'arrow static',true)
	setObjectCamera('center_Note_Static','camHUD')
	addLuaSprite('center_Note_Static', false);
	scaleObject('center_Note_Static', .8, .8);
	doTweenAlpha("centerNoteA","center_Note_Static",0,0.0001,'cubeOut')

	
	makeAnimatedLuaSprite('center_Note_Anim', 'notes/Sarah/Sarah_NoteSpecial', 0, 0);
	addAnimationByPrefix('center_Note_Anim','down confirm','down confirm',24,false);
	setObjectCamera('center_Note_Anim','camHUD')
	scaleObject('center_Note_Anim', .65, .65);
	setProperty('center_Note_Anim.visible',false)
	addLuaSprite('center_Note_Anim', true);
	
	secPerBeat = 60/curBpm

end


function onStepHit( ... )
	if curStep == 1 then
		noteX0 = defaultPlayerStrumX0
		noteX1 = defaultPlayerStrumX1
		noteX2 = defaultPlayerStrumX2
		noteX3 = defaultPlayerStrumX3
		

		setProperty('center_Note_Static.x',defaultPlayerStrumX1+50)
		setProperty('center_Note_Static.y',defaultPlayerStrumY1)

		setProperty('center_Note_Anim.x',defaultPlayerStrumX1+14)
		setProperty('center_Note_Anim.y',defaultPlayerStrumY1-35)
	end

end

function onBeatHit( ... )
	if curBeat == 44 then
		noteSpread(50,secPerBeat*4)
	end

	if curBeat == 64 then
		noteSpread(0,secPerBeat*2)
	end

	if curBeat == 128 then
		noteSpread(50,secPerBeat)
	end

	if curBeat == 144 then
		noteSpread(0,secPerBeat)
	end

	if curBeat == 198 then
		secPerBeat = 60/curBpm
		noteSpread(50,secPerBeat)
	end

	if curBeat == 214 then
		noteSpread(0,secPerBeat)
	end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		setProperty('center_Note_Anim.visible',true)
		objectPlayAnimation('center_Note_Anim', 'down confirm',true)
		runTimer('centerPressed', .15)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'centerPressed' then
		setProperty('center_Note_Anim.visible',false)
	end
end

function noteSpread(offset,duration)
	noteTweenX('noteX0',4, noteX0 - offset, duration, 'cubeOut')
	noteTweenX('noteX1',5, noteX1 - offset, duration, 'cubeOut')
	noteTweenX('noteX2',6, noteX2 + offset, duration, 'cubeOut')
	noteTweenX('noteX3',7, noteX3 + offset, duration, 'cubeOut')
	
	if offset == 0 then
		doTweenAlpha("centerNoteA","center_Note_Static",0,duration,'cubeOut')
	else
		doTweenAlpha("centerNoteA","center_Note_Static",1,duration,'cubeOut')
	end
end

