
local noteName = 'Nico_NoteSpecial'
local filePath = 'notes/Nico/Nico_NoteSpecial'

local timer = 0



function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true);
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'offsetX', -20); --Miss has no penalties
			setPropertyFromGroup('unspawnNotes', i, 'offsetY', -20); --Miss has no penalties
			
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
	makeLuaSprite('halfWhiteFrame', 'common/whiteFrame', 0, 0);
	setObjectCamera('halfWhiteFrame','camHUD')
	doTweenColor('halfWhiteFrameC','halfWhiteFrame','FC7DB7',.00001)
	doTweenAlpha("halfWhiteFrameOK","halfWhiteFrame",0,0.00001,'cubeOut')
	setBlendMode('halfWhiteFrame', 'add')
	addLuaSprite('halfWhiteFrame')
end

function onUpdate( elapse )
	if timer >= 0 then
		time  = time - elapse
	end

end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		playParticle("nico_note"..noteData,true)
		timer = 5
		doTweenAlpha("halfWhiteFrameOK2","whatever",0,.0001)
		doTweenAlpha("halfWhiteFrameOK1","halfWhiteFrame",.7,1,'cubeOut')
		playSound('nico_note',.7)
	end
end

function onTweenCompleted( tag )
	if tag == "halfWhiteFrameOK1" then
		doTweenAlpha("halfWhiteFrameOK2","halfWhiteFrame",0,4,'quadIn')
	end
end


function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
	end
end

function onStepHit( ... )
	if curStep == 1 then
	makePexParticle("nico_note0",defaultPlayerStrumX0+62,defaultPlayerStrumY0+50,1,"camHUD")
	makePexParticle("nico_note1",defaultPlayerStrumX1+62,defaultPlayerStrumY1+50,1,"camHUD")
	makePexParticle("nico_note2",defaultPlayerStrumX2+62,defaultPlayerStrumY2+50,1,"camHUD")
	makePexParticle("nico_note3",defaultPlayerStrumX3+62,defaultPlayerStrumY3+50,1,"camHUD")
	end
end
