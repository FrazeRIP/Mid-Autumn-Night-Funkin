local allowEnd = false
local sprites = {}

function onEndSong()
	if not allowEnd and isStoryMode then
	--if not allowEnd then
		setProperty('inCutscene', true);
		setProperty('isFirstDialogue',false)
		setProperty('dialogueCount',0)

		
		loadBlack()
		doTweenAlpha("dialogueBackA3","camDialogueBack",1,.2,'cubeOut')
		doTweenAlpha("camHUDA","camHUD",0,.2,'cubeOut')
		doTweenAlpha("dialogueA3","camDialogue",1,.2,'cubeOut')
		startDialogue('dialogueAfter', 'breakfast');
		preloadAssets()
		allowEnd = true
		return Function_Stop;
	end
	return Function_Continue;
end

----------------------------------------------------------------------
--Setting---------------------------------------------------------
folderName  = "Kris/"
function preloadAssets()
	addCG("CG2",folderName.."CG2")
end

function onNextDialogueAfter(count)
	if count == 4 then
		setProperty('isLockDialogue',true)
		doTweenAlpha("dialogueBackA3","camDialogueBack",0,.1,'cubeOut')
		doTweenAlpha("CG2A","CG2",1,2,'cubeOut')
	end
	
	if count == 5 then
		doTweenAlpha("dialogueBackA3","camDialogueBack",1,.1,'cubeOut')
		doTweenAlpha("CG2A","CG2",0,.5,'cubeOut')
	end

end


function onTweenCompleted( tag )
	if tag == 'CG2A' then
		setProperty('isLockDialogue',false)
	end
end

function onDialogueFinished()
	doTweenAlpha("dialogueBackA3","camDialogueBack",0,.2,'cubeOut')
	doTweenAlpha("dialogueA3","camDialogue",0,.2,'cubeOut')
	doTweenAlpha("camHUDA","camHUD",0,.2,'cubeOut')

	for key,value in pairs(sprites) do 
		removeLuaSprite(value)
		end

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

function loadBlack()
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black', 1280, 720, '000000')
	setScrollFactor('black', 0, 0);
	setObjectCamera('black','camDialogueBack')
	addLuaSprite('black', true);
	doTweenAlpha("blackA", 'black', 0.3,0.0001)
end
