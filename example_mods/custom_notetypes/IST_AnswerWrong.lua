
local noteName = 'IST_AnswerWrong'
local filePath = 'notes/IST/IST_Answer'

function onCreate()

	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', hurtAmount); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
		end
	end
	--debugPrint('Script started!')
end

function onCreatePost( ... )
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		triggerEvent("Play Animation", 'singRIGHTmiss', 'bf')
		playSound('damage',.7)
		cameraShake('camGame', .01, .45)
	end
end
