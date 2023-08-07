local allowCountdown = false
local sprites = {}

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
	--if not allowCountdown and not seenCutscene then
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
	
		loadBlack()
		doTweenAlpha("camHUDA","camHUD",0,.2,'cubeOut')
		startDialogue('dialogueBefore', 'breakfast');
		preloadAssets()
	end
end

----------------------------------------------------------------------
function preloadAssets()
end

function onNextDialogue(count)
end

function onSkipDialogue(count)
end


function onTweenCompleted( tag )
end


function onDialogueFinished()
	doTweenAlpha("dialogueBackA3","camDialogueBack",0,.2,'cubeOut')
	doTweenAlpha("dialogueA3","camDialogue",0,.2,'cubeOut')
	doTweenAlpha("camHUDA","camHUD",1,.2,'cubeOut')

	for key,value in pairs(sprites) do 
		removeLuaSprite(value)
		end
		
	removeLuaSprite('black')
end


--Setting---------------------------------------------------------
folderName  = "Paola/"


function loadBlack()
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black', 1280, 720, '000000')
	setScrollFactor('black', 0, 0);
	setObjectCamera('black','camDialogueBack')
	addLuaSprite('black', true);
	doTweenAlpha("blackA", 'black', 0.3,0.0001)
end

function addCG( tag, filename )
	makeLuaSprite(tag, 'cgs/'..filename, 0, 0);
	setObjectCamera(tag,'camDialogue')
	setScrollFactor(tag, 1, 1)
	addLuaSprite(tag, true);
	scaleObject(tag,1,1)
	table.insert(sprites, tag)
	doTweenAlpha(tag.."A", tag, 0,0.0001)
end


