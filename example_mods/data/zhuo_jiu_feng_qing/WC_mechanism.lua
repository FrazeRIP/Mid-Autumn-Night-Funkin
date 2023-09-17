
local noteName = 'WhiteCat_NoteSpecial'
local secPerBeat=0
---------------
--Position
local downScollY = 520
local downScollUIItemY = 530

local upScollY = 150
local upScollUIItemY = 160

local itemPosArray = {530,595,658}
-----------
--Coditions
local canReceiveInput = false;
local isGoingDown = true;
---------------
--Array
local collectedArray = {0}
local itemsArray = {"1", "2", "3"}
---------------
--Count
local currentItemIndex = -1
local timer = 1
---------------

function onCreatePost()
	math.randomseed(os.time())
	secPerBeat = 60/curBpm
	--generate collectable
	for i = 1, #itemsArray do
		makeLuaSprite('item'..itemsArray[i], 'mechanism/Whitecat/item'..itemsArray[i], -999, -999)
		setObjectCamera('item'..itemsArray[i], 'camHUD') 
		addLuaSprite('item'..itemsArray[i], false)
		scaleObject('item'..itemsArray[i], 0.75, 0.75)  
		--doTweenAlpha('item'..itemsArray[i].."A", 'item'..itemsArray[i], 0,0.0001)
	end
	--generate icon ui
	makeLuaSprite('inventory01', 'mechanism/Whitecat/inventory01', 490, downScollY)
	setObjectCamera('inventory01', 'camHUD') 
	scaleObject('inventory01', 0.3, 0.3)  
	addLuaSprite('inventory01', true)
	doTweenAlpha("inventory01A","inventory01",0,0.00001,'quadOut')
	
	for i = 1, #itemsArray do
		makeLuaSprite('icon'..itemsArray[i], 'mechanism/Whitecat/icon'..itemsArray[i], itemPosArray[i], downScollUIItemY)
		setObjectCamera('icon'..itemsArray[i], 'camHUD') 
		addLuaSprite('icon'..itemsArray[i], true)
		
		makePexParticle("wc_"..itemsArray[i],itemPosArray[i] +30, downScollUIItemY +30,1,"camHUD")
		
		doTweenColor('icon'..itemsArray[i].."C",'icon'..itemsArray[i],'2C2C2C',.0001)
		doTweenAlpha('icon'..itemsArray[i].."A", 'icon'..itemsArray[i], 0,0.0001)
	end
	
	if downscroll then
		doTweenY('inventory01Y', 'inventory01', downScollY, 0.0001)
		for i = 1, #itemsArray do
			doTweenY('icon'..itemsArray[i].."Y", 'icon'..itemsArray[i], downScollUIItemY, 0.0001)
		end
	else
		doTweenY('inventory01Y', 'inventory01', upScollY, 0.0001)
		for i = 1, #itemsArray do
			doTweenY('icon'..itemsArray[i].."Y", 'icon'..itemsArray[i], upScollUIItemY, 0.0001)
		end
	end
	
end


function onBeatHit( ... )
	if curBeat == 76 then
		if downscroll then
			doTweenY('inventory01Y', 'inventory01', downScollY+40, 0.0001)

			for i = 1, #itemsArray do
				doTweenY('icon'..itemsArray[i].."Y", 'icon'..itemsArray[i], downScollUIItemY+20, 0.0001)
			end
		else
			doTweenY('inventory01Y', 'inventory01', upScollY-40, 0.0001)

			for i = 1, #itemsArray do
				doTweenY('icon'..itemsArray[i].."Y", 'icon'..itemsArray[i], upScollUIItemY+20, 0.0001)
			end
		end
	end

	if curBeat == 78 then
		if downscroll then
			doTweenY('inventory01Y', 'inventory01', downScollY,3*secPerBeat,'elasticOut')
		else
			doTweenY('inventory01Y', 'inventory01', upScollY,3*secPerBeat,'elasticOut')
		end
		doTweenAlpha("inventory01A","inventory01",1,secPerBeat*1.5,'cubeOut')
	end

	--if curBeat == 80 then
	--	for i = 1, #itemsArray do
	--		doTweenAlpha('icon'..itemsArray[i].."A", 'icon'..itemsArray[i], 1,secPerBeat*2,'cubeOut')
	--	end
	--end

end

function onStepHit( ... )
	if curStep == 316 then
		doTweenAlpha('icon'..itemsArray[1].."A", 'icon'..itemsArray[1], 1,secPerBeat,'cubeOut')

		if downscroll then
			doTweenY('icon'..itemsArray[1].."Y", 'icon'..itemsArray[1], downScollUIItemY, 2*secPerBeat,'elasticOut')
		else
			doTweenY('icon'..itemsArray[1].."Y", 'icon'..itemsArray[1], upScollUIItemY, 2*secPerBeat,'elasticOut')
		end
	end

	if curStep == 317 then 
		doTweenAlpha('icon'..itemsArray[2].."A", 'icon'..itemsArray[2], 1,secPerBeat,'cubeOut')

		if downscroll then
			doTweenY('icon'..itemsArray[2].."Y", 'icon'..itemsArray[2], downScollUIItemY, 2*secPerBeat,'elasticOut')
		else
			doTweenY('icon'..itemsArray[2].."Y", 'icon'..itemsArray[2], upScollUIItemY, 2*secPerBeat,'elasticOut')
		end
	end

	if curStep == 318 then 
		doTweenAlpha('icon'..itemsArray[3].."A", 'icon'..itemsArray[3], 1,secPerBeat,'cubeOut')

		if downscroll then
			doTweenY('icon'..itemsArray[3].."Y", 'icon'..itemsArray[3], downScollUIItemY, 2*secPerBeat,'elasticOut')
		else
			doTweenY('icon'..itemsArray[3].."Y", 'icon'..itemsArray[3], upScollUIItemY, 2*secPerBeat,'elasticOut')
		end
	end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		collectItem(0,true)
	end
end

function onUpdate( elapsed )
	if curBeat >=80 then
		timer = timer - elapsed

		if timer <= 0 then
			generateItem(math.random(1,3))
			timer = math.random(9,12)
		end
	end

	local isSpacePressed = keyJustPressed('space')

	if isSpacePressed then
		collectItem(currentItemIndex,false)
	end
end


-----------------------------------------------

local function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
-----------------------------------------------

function collectItem(index,isForce)
	
	if botPlay then
		playSound('error',.5)
		return
	end

	if canReceiveInput or isForce then
		debugPrint(index)
		if hasValue(collectedArray,index) then
			for i = 1, #collectedArray do
				doTweenColor('icon'..collectedArray[i].."C1", 'icon'..collectedArray[i],'A30000',0.25,'cubeOut')
			end
			if not isForce then
				playSound('error',1)
			end
			cameraShake('camHUD', .0025, .3)
			collectedArray = {0}
		else
			doTweenColor('icon'..itemsArray[index].."C",'icon'..itemsArray[index],'FFFFFF',0.5,'cubeOut')
			playSound('wc_collectSuccess',1)
			playParticle("wc_"..itemsArray[index],true)
			table.insert(collectedArray, index)
		end
		
		for i = 1, 3 do
			doTweenAlpha('item'..tostring(i).."A", 'item'..tostring(i), 0, 0.5,'cubeOut')
		end
		canReceiveInput = false
	end
end

function generateItem(index)
	currentItemIndex = index
    randomX = math.random(200,1080)
	
	local yStart = -300
	local yEnd = 760

	if not isGoingDown then
		yStart = 760
		yEnd = -300
	end

	isGoingDown = not isGoingDown

	doTweenAlpha('item'..tostring(index).."A", 'item'..tostring(index), 1, 0.0001)
	doTweenX('item'..tostring(index).."Y", 'item'..tostring(index), randomX, 0.0001)
	doTweenY('item'..tostring(index).."Y1", 'item'..tostring(index), yStart, 0.0001)
	doTweenY('item'..tostring(index).."Y2", 'item'..tostring(index), yEnd, 8)
	doTweenAngle('item'..tostring(index).."R1", 'item'..tostring(index), -90, 0.0001)
	doTweenAngle('item'..tostring(index).."R2", 'item'..tostring(index), 90, 8)
	
	canReceiveInput = true
end

function onTweenCompleted( tag )
	for i = 1, 3 do
		if tag == 'icon'..tostring(i).."C1" then
			doTweenColor('icon'..tostring(i).."C2", 'icon'..tostring(i),'2C2C2C',.5,'cubeIn')
		end
	end
end

