
local noteName = 'IST_AnswerGood'
local filePath = 'notes/IST/IST_Answer'

function onCreate()

	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', hurtAmount); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				if not botPlay then
					setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
				end
			end

		end
	end
	--debugPrint('Script started!')
end

function onCreatePost( ... )
	makeAnimatedLuaSprite('refute bubble', 'mechanism/IST/refute bubble', 300, 300);
	addAnimationByPrefix('refute bubble', 'refute bubble', 'refute bubble', 48, false);
	addLuaSprite('refute bubble', true);
	setProperty('refute bubble.visible', false)
	objectPlayAnimation('refute bubble', 'refute bubble', true)
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		triggerEvent("Play Animation", 'hey', 'bf')
		playSound('counter',.9)
		setProperty('refute bubble.visible', true)
		objectPlayAnimation('refute bubble', 'refute bubble', true)
		runTimer('refute bubbleT', 1)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'refute bubbleT' then
		setProperty('refute bubble.visible', false)
	end
end

