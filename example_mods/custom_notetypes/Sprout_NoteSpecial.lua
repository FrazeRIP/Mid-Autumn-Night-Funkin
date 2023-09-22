
local noteName = 'Sprout_NoteSpecial'
local filePath = 'notes/Sprout/Sprout_NoteSpecial'
local secPerBeat = 0

local spawnCount =0

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteName then
			setPropertyFromGroup('unspawnNotes', i, 'texture', filePath); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.025'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.1'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

		end
	end
end

function onCreatePost( ... )
	secPerBeat = 60/curBpm
	for i = 1,9 do
		precacheImage('mechanism/Sprout/ink'..tostring(i))
	end
	
	makeLuaSprite('inkAttack', 'mechanism/Sprout/inkAttack', 0,500)
	addLuaSprite('inkAttack', true)
	doTweenAlpha('inkAttackA', 'inkAttack', 0,0.0001)
	scaleObject('inkAttack', .8, .8);

	makeLuaSprite('inkDamage', 'mechanism/Sprout/inkDamage', 580,480)
	addLuaSprite('inkDamage', true)
	doTweenAlpha('inkDamageA', 'inkDamage', 0,0.0001)
end

function onStepHit( ... )
	if curStep == 1 then
		local offsetX = -75
		local offsetY = -75
		--------------------------
		local i = 0
		makeLuaSprite('inkSplat'..tostring(i), 'mechanism/Sprout/inkSplat', defaultPlayerStrumX0+offsetX,defaultPlayerStrumY0+offsetY)
		setObjectCamera('inkSplat'..tostring(i), 'camHUD') 
		addLuaSprite('inkSplat'..tostring(i), true)
		doTweenAlpha('inkSplat'..tostring(i).."A", 'inkSplat'..tostring(i), 0,0.0001)
		--------------------------
		local i = 1
		makeLuaSprite('inkSplat'..tostring(i), 'mechanism/Sprout/inkSplat', defaultPlayerStrumX1+offsetX,defaultPlayerStrumY1+offsetY)
		setObjectCamera('inkSplat'..tostring(i), 'camHUD') 
		addLuaSprite('inkSplat'..tostring(i), true)
		doTweenAlpha('inkSplat'..tostring(i).."A", 'inkSplat'..tostring(i), 0,0.0001)
		--------------------------
		local i = 2
		makeLuaSprite('inkSplat'..tostring(i), 'mechanism/Sprout/inkSplat', defaultPlayerStrumX2+offsetX,defaultPlayerStrumY2+offsetY)
		setObjectCamera('inkSplat'..tostring(i), 'camHUD') 
		addLuaSprite('inkSplat'..tostring(i), true)
		doTweenAlpha('inkSplat'..tostring(i).."A", 'inkSplat'..tostring(i), 0,0.0001)
		--------------------------
		local i = 3
		makeLuaSprite('inkSplat'..tostring(i), 'mechanism/Sprout/inkSplat', defaultPlayerStrumX3+offsetX,defaultPlayerStrumY3+offsetY)
		setObjectCamera('inkSplat'..tostring(i), 'camHUD') 
		addLuaSprite('inkSplat'..tostring(i), true)
		doTweenAlpha('inkSplat'..tostring(i).."A", 'inkSplat'..tostring(i), 0,0.0001)
		--------------------------
	end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		characterPlayAnim('bf','dodge',true)
		setProperty("boyfriend.specialAnim",true)
		setProperty("boyfriend.heyTimer",.3)
		setProperty("forceAnimTimer",.3)


		triggerEvent("Play Animation", 'SHOOSH', 'dad')
		playSound('inkSplat',.7)
		doTweenAlpha('inkAttackA', 'inkAttack', 1,0.0001)
		doTweenX('inkAttackAX1', 'inkAttack', 200,0.0001)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == noteName then
		characterPlayAnim('bf','singRIGHTmiss',true)
		setProperty("boyfriend.specialAnim",true)
		setProperty("boyfriend.heyTimer",.3)
		setProperty("forceAnimTimer",.3)
		cameraShake('camGame', .01, .45)

		triggerEvent("Play Animation", 'SHOOSH', 'dad')
		playSound('inkSplat',1)
		playSound('damage',.6)
		doTweenAlpha('inkAttackA', 'inkAttack', 1,0.0001)
		doTweenX('inkAttackAX1', 'inkAttack', 300,0.0001)
		
		doTweenAlpha('inkSplat'..noteData.."A1", 'inkSplat'..noteData, .8,0.0001)
		doTweenX('inkSplat'..noteData.."X1", 'inkSplat'..noteData..'.scale', .7,0.0001)
		doTweenY('inkSplat'..noteData.."Y1", 'inkSplat'..noteData..'.scale', .7,0.0001)

		doTweenAlpha('inkDamageA1', 'inkDamage', .7,0.0001)
		doTweenAlpha('inkDamageA2', 'inkDamage', 0,secPerBeat*2,'quadIn')
		generateInkText()
	end
end

function onTweenCompleted( tag )
	if tag == 'inkAttackAX1' then
		doTweenX('inkAttackAX2', 'inkAttack', 230,secPerBeat*.8,'cubeOut')
		doTweenAlpha('inkAttackA', 'inkAttack', 0,secPerBeat*.8,'cubeIn')
	end

	for i = 0, 3 do
		if tag == 'inkSplat'..tostring(i).."A1" then
			doTweenAlpha('inkSplat'..tostring(i).."A2", 'inkSplat'..tostring(i), 0,secPerBeat*4,'quadIn')
			doTweenX('inkSplat'..tostring(i).."X2", 'inkSplat'..tostring(i)..'.scale', 1,secPerBeat/4,'cubeOut')
			doTweenY('inkSplat'..tostring(i).."Y2", 'inkSplat'..tostring(i)..'.scale', 1,secPerBeat/4,'cubeOut')
			
		end
	end
end

function generateInkText()
		local i = getRandomInt(1,7,false)
		local offsetXMin = -100
		local offsetXMax = 500

		local offsetYMin = 100
		local offsetYMax = 400

		local offsetAngleMin = -45
		local offsetAngleMax = 45

		local name = 'item'..tostring(i)..tostring(spawnCount)

		makeLuaSprite(name, 'mechanism/Sprout/ink'..tostring(i), getRandomInt(offsetXMin,offsetXMax,false), getRandomInt(offsetYMin,offsetYMax,false))
		doTweenAngle(name..'Angle', name,getRandomInt(offsetAngleMin,offsetAngleMax,false) ,0.0001)
		doTweenAlpha(name..'A1', name, .8,0.0001,'quadIn')
		doTweenAlpha(name..'A2', name, 0,5,'quadIn')
		setObjectCamera(name, 'camHUD') 
		addLuaSprite(name, false)
		--scaleObject('item'..tostring(i), 0.75, 0.75)  
		spawnCount = spawnCount +1
end

