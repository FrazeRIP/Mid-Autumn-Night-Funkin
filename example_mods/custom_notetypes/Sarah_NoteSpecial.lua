
local noteName = 'Sarah_NoteSpecial'
local filePath = 'notes/Sarah/Sarah_NoteSpecial'

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
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'noteData', '4'); 
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
				setPropertyFromGroup('unspawnNotes', i, 'offsetX', -180);
			else
				setPropertyFromGroup('unspawnNotes', i, 'offsetX', -220);
			end
		end
	end
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
