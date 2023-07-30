local allowCountdown = false
local sprites = {}

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	--if not allowCountdown and isStoryMode and not seenCutscene then
	if not allowCountdown and not seenCutscene then
	--if not isStoryMode then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		

	setProperty('isFirstDialogue',true)
	return Function_Stop;
	end

	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)

	if tag == 'startDialogue' then -- Timer completed, play dialogue
		--doTweenAlpha("camHUDA","camHUD",0,.2,'cubeOut')
		preloadAssets()
		startDialogue('dialogueBefore', 'breakfast');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
		
end

function onSkipDialogue(count)
	

end


function onTweenCompleted( tag )

end


function onDialogueFinished()
	doTweenAlpha("dialogueBackA3","camDialogBack",0,.2,'cubeOut')
	doTweenAlpha("dialogueA3","camDialog",0,.2,'cubeOut')
	doTweenAlpha("camHUDA","camHUD",1,.2,'cubeOut')

	for key,value in pairs(sprites) do 
		removeLuaSprite(value)
		end

end


--Setting---------------------------------------------------------
folderName  = "Paola"

function preloadAssets()
	addCG("CG1",folderName.."/".."CG1")
end


function addCG( tag, filename )
	makeLuaSprite(tag, 'cgs/'..filename, 0, 0);
	setObjectCamera(tag,'camDialogBack')
	setScrollFactor(tag, 1, 1)
	addLuaSprite(tag, true);
	scaleObject(tag,1,1)
	table.insert(sprites, tag)
	--doTweenAlpha(tag.."A", tag, 0,0.0001)
end

function removeCG(tag)
end

