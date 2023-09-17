
local noteName = 'WhiteCat_NoteSpecial'
local filePath = 'notes/WhiteCat/'

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath..noteName); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '-0.1'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.1'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashDisabled', true);
			
		end
	end
end


function onCreatePost( ... )
	makeLuaSprite('feedback', filePath..'WhiteCat_NoteFeedback', 0 , 0 )
	setObjectCamera('feedback', 'camHUD') 
	doTweenAlpha("feedbackA","feedback",0,.0001)
	addLuaSprite('feedback',true)
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		
		noteX = 0
		noteY = 0

		if noteData == 0 then
			noteX = defaultPlayerStrumX0
			noteY = defaultPlayerStrumY0
		elseif noteData == 1 then
			noteX = defaultPlayerStrumX1
			noteY = defaultPlayerStrumY1
		elseif noteData == 2 then
			noteX = defaultPlayerStrumX2
			noteY = defaultPlayerStrumY2
		elseif noteData == 3 then
			noteX = defaultPlayerStrumX3
			noteY = defaultPlayerStrumY3
		end

		doTweenX('feedbackX', 'feedback',noteX, 0.0001)
		doTweenY('feedbackY', 'feedback',noteY -5, 0.0001)
		doTweenColor('feedbackC','feedback','FF0000',.0001)
		doTweenAlpha("feedbackA1","feedback",1,.001)

		playSound('wc_noteSpecial',1)
		cameraShake('camHUD', 0.005, .25)
	end
end

function onTweenCompleted( tag )
	if tag == "feedbackA1" then
		doTweenColor('feedbackC','feedback','FFFFFF',.25,'cubeOut')
		doTweenAlpha("feedbackA2","feedback",0,.75,'cubeIn')
	end
end
