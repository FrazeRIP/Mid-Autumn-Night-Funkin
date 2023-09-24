
local noteName = 'PinkGhost_BadNote'
local filePath = 'notes/PinkGhost/PinkGhost_NoteSpecial'



function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

function onCreatePost( ... )
	--createNoteSplash()
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		triggerEvent("Play Animation", 'singRIGHTmiss', 'bf')
		playSound('error',.7)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
	
	end
end
