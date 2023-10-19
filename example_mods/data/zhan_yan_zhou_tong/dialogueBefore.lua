local allowCountdown = false
local sprites = {}


stageName = "dan_qiu"
function onCreatePost( ... )
	if not allowCountdown and isStoryMode and not seenCutscene then
		makeLuaSprite('dialogueBG', 'dialogueBG/'..stageName, 0, 0);
		setObjectCamera('dialogueBG','camDialogueBack')
		--setScrollFactor(tag, 1, 1)
		addLuaSprite('dialogueBG', true);
		doTweenColor('dialogueBGC','dialogueBG', 'C7C7C7',2, 'cubeOut')
	end
end

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
--Setting---------------------------------------------------------
folderName  = "Kris/"

function preloadAssets()
	addCG("CG1",folderName.."CG1")
	addCG("CG2",folderName.."CG2")
end

function onNextDialogue(count)

	if count == 4 then
		setProperty('isLockDialogue',true)
		doTweenAlpha("dialogueA3","camDialogue",0,.1,'cubeOut')
		doTweenAlpha("CG1A","CG1",1,2,'cubeOut')
	end

	if count == 5 then
		setProperty('isLockDialogue',true)
		doTweenAlpha("dialogueA3","camDialogue",0,.1,'cubeOut')
		doTweenAlpha("CG2A","CG2",1,.5,'cubeOut')
	end
	
	if count == 6 then
		doTweenAlpha("dialogueA3","camDialogue",1,.1,'cubeOut')
		doTweenAlpha("CG2A","CG2",0,.5,'cubeOut')
		doTweenAlpha("CG1AO","CG1",0,.5,'cubeOut')
	end

end

function onSkipDialogue(count)
end


function onTweenCompleted( tag )
	if tag == 'CG1A' then
		setProperty('isLockDialogue',false)
	end
	if tag == 'CG2A' then
		setProperty('isLockDialogue',false)
	end
end


function onDialogueFinished()
	doTweenAlpha("dialogueBackA3","camDialogueBack",0,.2,'cubeOut')
	doTweenAlpha("dialogueA3","camDialogue",0,.2,'cubeOut')

	for key,value in pairs(sprites) do 
		removeLuaSprite(value)
		end
		
	removeLuaSprite('black')
end

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
	setObjectCamera(tag,'camDialogueBack')
	setScrollFactor(tag, 1, 1)
	addLuaSprite(tag, true);
	scaleObject(tag,1,1)
	table.insert(sprites, tag)
	doTweenAlpha(tag.."A", tag, 0,0.0001)
end


