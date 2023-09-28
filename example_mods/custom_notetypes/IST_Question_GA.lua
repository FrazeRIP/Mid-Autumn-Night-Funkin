
local noteName = 'IST_Question_GA'
local filePath = 'notes/IST/IST_Question'

function onCreate()

	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', hurtAmount); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);

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
