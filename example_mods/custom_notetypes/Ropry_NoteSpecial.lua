
local noteName = 'Ropry_NoteSpecial'
local filePath = 'notes/Ropry/Ropry_NoteSpecial'


function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true);
		end
	end
	--debugPrint('Script started!')
end


function onCreatePost( ... )
	--createNoteSplash()
end


function onStepHit( ... )
	if curStep == 1 then
	makePexParticle("ropry_star",defaultPlayerStrumX2+50,defaultPlayerStrumY2+50,1,"camHUD")
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		triggerEvent("Play Animation", 'hey', 'bf')
		setProperty("dad.heyTimer",3)
		playParticle("ropry_star",true)
		playSound('damage',.5)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
			cameraShake('camGame', .01, .35)
			setProperty('health',0.01)
	end
end
