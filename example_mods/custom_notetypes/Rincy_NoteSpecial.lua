
local noteName = 'Rincy_NoteSpecial'
local filePath = 'notes/Rincy/Rincy_NoteSpecial'


local timer = 0
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
		end
	end
end

function onStepHit( ... )
	if curStep == 1 then
	makePexParticle("rc_note0",defaultPlayerStrumX0+50,defaultPlayerStrumY0+50,1,"camHUD")
	makePexParticle("rc_note1",defaultPlayerStrumX1+50,defaultPlayerStrumY1+50,1,"camHUD")
	makePexParticle("rc_note2",defaultPlayerStrumX2+50,defaultPlayerStrumY2+50,1,"camHUD")
	makePexParticle("rc_note3",defaultPlayerStrumX3+50,defaultPlayerStrumY3+50,1,"camHUD")
	end

end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		playParticle("rc_note"..noteData,true)
		timer = 5
		playSound('rc_note',.7)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		
	end
end

function onUpdatePost(v)
	timer = timer - v
	if timer >= 0 then
        Fade()
	end
end



local yStart1 = 520
local yEnd1 = 60

local yStart2 = 0
local yEnd2 = 600

local multiplyer = 1
function Fade()
    for i = 0,getProperty('notes.length')-1 do
    gety = getPropertyFromGroup('notes',i,'y')
        if downscroll  then
            if gety >= yStart2 then
            setPropertyFromGroup('notes',i,'alpha',1- ((yStart2-gety)*(1/(yStart2-yEnd2)))* multiplyer)
            end
        else
            if gety <= yStart1 then
            setPropertyFromGroup('notes',i,'alpha',1-((yStart1-gety)*(1/(yStart1-yEnd1)))* multiplyer)
            end
        end
    end
end