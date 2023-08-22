-- Original script by TPOSEJANK, changed a ton by 💜 Rodney, An Imaginative Person 💙! lol

local moviesOffset = {x = 35, y = 32} -- x and y movement force
local whosActive = {oppo = true, play = true} -- who has de cool movesment
local ifCamLocked = { -- cool cam lock stuff
	oppo = {active = false, x = 0, y = 0},
	play = {active = false, x = 0, y = 0}
}
local velocity = { -- sonic.exe lol
	active = false,
	defSpeed = 1,
	speedAdd = 0.5, -- Yes your reading that right, `ADD`.
	-- Don't feel like allowing the events to edit this one lol. Plus this one ain't `velocity` related lmao.
	returnDelay = 5.6, -- OH and the recommended range is about 3 to 5 or 6 btw.
}

-- !! DON'T TOUCH ANYTHING BELOW THIS POINT !!

local camSpeedChecks = { -- Checks, for camera velocity.
	songHasStarted = false,
	updateDefSpeed = false
}
local appliedMoveForce = { -- `table` which has the applied `moviesOffset` force.
	{-moviesOffset.x, 0},
	{0, moviesOffset.y},
	{0, -moviesOffset.y},
	{moviesOffset.x, 0},
	{0,0}
}

-- Checks if a variable is `nil`.
---@param variable any The `variable` you want to check if `nil`.
---@param ifNil any What should be returned if the `variable` is `nil`.
---@return any ifNil Shall return `ifNil`.
local function checkifNil(variable, ifNil)
	return variable == nil and ifNil or variable
end

function onSongStart()
	-- fake cam pos stuff for "Manage Cam Dir Position Lock"
	runHaxeCode("setVar('camFollowFake', null);")
	setProperty('camFollowFake', {x = 0, y = 0})
	-- velocity stuff
	velocity.defSpeed = checkifNil(getProperty('cameraSpeed'), 1)
	camSpeedChecks.songHasStarted = true
end

function onUpdate()
	if camSpeedChecks.updateDefSpeed then velocity.defSpeed = checkifNil(getProperty('cameraSpeed'), checkifNil(velocity.defSpeed, 1)) end
	-- debugPrint(velocity.defSpeed, ' ', camSpeedChecks.updateDefSpeed, ' ', getProperty('cameraSpeed'))
end

-- Splits a `string` into a `table`.
---@param str string Where you input your `string`.
---@param delimiter table What causes the `string` to separate.
---@return table # Returns `string` as a `table`.
function splitString(str, delimiter)
	-- Cool shit Unholy 😎
	local result = {}
	for match in (str .. delimiter):gmatch('(.-)' .. delimiter) do
		table.insert(result, stringTrim(tostring(match)))
	end
	return result
end

-- If `ifCamLocked` local has `active` set to `true`.
---@param isP1 boolean Is it player or opponent who hit the note?
local function setLockedCamPos(isP1)
	if not getProperty('isCameraOnForcedPos') then
		if ifCamLocked.oppo.active and not isP1 then
			setProperty('camFollow.x', ifCamLocked.oppo.x)
			setProperty('camFollow.y', ifCamLocked.oppo.y)
		elseif ifCamLocked.play.active and isP1 then
			setProperty('camFollow.x', ifCamLocked.play.x)
			setProperty('camFollow.y', ifCamLocked.play.y)
		end
	end
end

local focusThingy
function onMoveCamera(focus)
	focusThingy = focus
	setLockedCamPos(mustHitSection)
	if velocity.active and camSpeedChecks.songHasStarted then
		setProperty('cameraSpeed', velocity.defSpeed)
		camSpeedChecks.updateDefSpeed = true
	end
end

local camManagement = {v1 = {focusThingy, 'Scripted Char Sing'}, v2 = {focusThingy, ''}}
-- Basically `moveCameraSection()` from source but now in lua ig?
---@param noteType string Your specified `noteType`.
local function moveCameraSection(noteType)
	if not getProperty('isCameraOnForcedPos') then
		runHaxeCode('game.moveCameraSection();')
		if noteType == camManagement.v1[2] then setToCharCamPosition(camManagement.v1[1], {camManagement.v2[1], camManagement.v2[2]}, true) end
		setLockedCamPos(mustHitSection)
	end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if mustHitSection then
		moveCamNoteDir(true, noteData, noteType, isSustainNote)
	end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if not mustHitSection then
		moveCamNoteDir(false, noteData, noteType, isSustainNote)
	end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
	if mustHitSection then
		moveCamNoteDir(true, noteData, noteType, isSustainNote)
	end
	--if mustHitSection and not lowQuality and whosActive.play and not getProperty('isCameraOnForcedPos') then
	--	moveCameraSection(noteType)
	--	setProperty('camFollowPos.x', getProperty('camFollow.x'))
	--	setProperty('camFollowPos.y', getProperty('camFollow.y'))
	--end
	--if velocity.active and mustHitSection then
	--	setProperty('cameraSpeed', velocity.defSpeed)
	--	camSpeedChecks.updateDefSpeed = true
	--end
end
function noteMissPress(direction)
	--if mustHitSection then
	--	moveCamNoteDir(true, noteData, noteType, isSustainNote)
	--end
	--if mustHitSection and not lowQuality and whosActive.play and not getProperty('isCameraOnForcedPos') then
	--	moveCameraSection('')
	--	setProperty('camFollowPos.x', getProperty('camFollow.x'))
	--	setProperty('camFollowPos.y', getProperty('camFollow.y'))
	--end
	--if velocity.active then
	--	setProperty('cameraSpeed', velocity.defSpeed)
	--	camSpeedChecks.updateDefSpeed = true
	--end
end

function onEvent(name, value1, value2)
	if name == 'Camera Set Target' then
		local splitContents = {v1 = {}, v2 = {}}
		splitContents.v1 = splitString(value1, ',')
		splitContents.v2 = splitString(value2, ',')
		setToCharCamPosition(splitContents.v1[1], {splitContents.v2[1], splitContents.v2[2]}, true)
	end
	
	if name == 'Set Property' and value1 == 'cameraSpeed' then
		velocity.defSpeed = checkifNil(tonumber(value2), velocity.defSpeed)
	end
	
	if name == 'Manage Cam Dir Movement' then
		camManagement.v1 = splitString(value1, ',')
		camManagement.v2 = splitString(value2, ',')
	end
	
	if name == 'Manage Cam Dir Properties' then
		local splitContents = {v1 = {}, v2 = {}}
		splitContents.v1 = splitString(value1, ',')
		splitContents.v2 = splitString(value2, ',')
		
		moviesOffset.x = checkifNil(tonumber(splitContents.v1[1]), moviesOffset.x)
		moviesOffset.y = checkifNil(tonumber(splitContents.v1[2]), moviesOffset.y)
		if splitContents.v1[3] == 'player' then
			whosActive.oppo = false
			whosActive.play = true
		elseif splitContents.v1[3] == 'opponent' then
			whosActive.oppo = true
			whosActive.play = false
		elseif splitContents.v1[3] == 'both' then
			whosActive.oppo = true
			whosActive.play = true
		elseif splitContents.v1[3] == 'none' then
			whosActive.oppo = false
			whosActive.play = false
		else
			if splitContents.v1[3] ~= nil then
				debugPrint('Please put "player", "opponent", "both" or "none".')
				debugPrint('Action "' .. splitContents.v1[3] .. '" is not a selectable thing.')
			end
		end
		
		velocity.active = checkifNil(splitContents.v2[1] == 'true' and true or false, velocity.active)
		velocity.speedAdd = checkifNil(tonumber(splitContents.v2[2]), velocity.speedAdd)
	end
	
	if name == 'Manage Cam Dir Position Lock' then
		local splitContents = {v1 = {}, v2 = {}}
		splitContents.v1 = splitString(value1, ',')
		splitContents.v2 = splitString(value2, ',')
		
		if type(tonumber(splitContents.v1[1])) == 'number' then
			ifCamLocked.oppo.active = true
			ifCamLocked.oppo.x = checkifNil(tonumber(splitContents.v1[1]), ifCamLocked.oppo.x)
			ifCamLocked.oppo.y = checkifNil(tonumber(splitContents.v1[2]), ifCamLocked.oppo.y)
		elseif splitContents.v1[1] == 'previous' then
			ifCamLocked.oppo.active = true
		elseif splitContents.v1[1] == 'update' then
			setLockedCamPos(mustHitSection)
		elseif splitContents.v1[1] == 'from char' then
			setToCharCamPosition(splitContents.v1[2], {splitContents.v1[3], splitContents.v1[4]}, false)
			ifCamLocked.oppo.x = checkifNil(getProperty('camFollowFake.x'), ifCamLocked.oppo.x)
			ifCamLocked.oppo.y = checkifNil(getProperty('camFollowFake.y'), ifCamLocked.oppo.y)
			ifCamLocked.oppo.active = true
		else
			ifCamLocked.oppo.active = false
		end
		
		if type(tonumber(splitContents.v2[1])) == 'number' then
			ifCamLocked.play.active = true
			ifCamLocked.play.x = checkifNil(tonumber(splitContents.v2[1]), ifCamLocked.play.x)
			ifCamLocked.play.y = checkifNil(tonumber(splitContents.v2[2]), ifCamLocked.play.y)
		elseif splitContents.v2[1] == 'previous' then
			ifCamLocked.play.active = true
		elseif splitContents.v2[1] == 'update' then
			setLockedCamPos(mustHitSection)
		elseif splitContents.v2[1] == 'from char' then
			setToCharCamPosition(splitContents.v2[2], {splitContents.v2[3], splitContents.v2[4]}, false)
			ifCamLocked.play.x = checkifNil(getProperty('camFollowFake.x'), ifCamLocked.play.x)
			ifCamLocked.play.y = checkifNil(getProperty('camFollowFake.y'), ifCamLocked.play.y)
			ifCamLocked.play.active = true
		else
			ifCamLocked.play.active = false
		end
	end
end

-- Converts extra key `noteData` into 4 key.
---@param noteData number The `noteData`.
---@param maniaVar number` The variable thats states the current amount of keys.
---@return number noteData Returns the `noteData` after the 4 key conversion.
local function noteDataEKConverter(noteData, maniaVar)
	if maniaVar == 1 then
		if noteData == 0 then return 2 end
		
	elseif maniaVar == 2 then
		if noteData == 1 then return 3 end
		
	elseif maniaVar == 3 then
		if noteData == 1 then return 2
		elseif noteData == 2 then return 3 end
		
		-- elseif maniaVar == 4 then
		
	elseif maniaVar == 5 then
		if noteData == 3 then return 2
		elseif noteData == 4 then return 3 end
		
	elseif maniaVar == 6 then
		if noteData == 1 then return 2
		elseif noteData == 2 then return 3
		elseif noteData == 3 then return 0
		elseif noteData == 4 then return 1
		elseif noteData == 5 then return 3 end
		
	elseif maniaVar == 7 then
		if noteData == 1 then return 2
		elseif noteData == 2 then return 3
		elseif noteData == 3 then return 2
		elseif noteData == 4 then return 0
		elseif noteData == 5 then return 1
		elseif noteData == 6 then return 3 end
		
	elseif maniaVar == 8 then
		if noteData == 4 then return 0
		elseif noteData == 5 then return 1
		elseif noteData == 6 then return 2
		elseif noteData == 7 then return 3 end
		
	elseif maniaVar == 9 then
		if noteData == 4 then return 2
		elseif noteData == 5 then return 0
		elseif noteData == 6 then return 1
		elseif noteData == 7 then return 2
		elseif noteData == 8 then return 3 end
		
	else
		return noteData
	end
end

---@param mustPress boolean Is it player or opponent who hit the note?
---@param noteData number` For which direction it should go in.
---@param noteType string `noteType` is here to do cool stuff with `setToCharCamPosition()`!
---@param isSustainNote boolean `isSustainNote` is only really here so if lowQuality is on, it prevents the movement.
function moveCamNoteDir(mustPress, noteData, noteType, isSustainNote)
	if lowQuality and isSustainNote then return Function_StopLua end
	noteData = noteDataEKConverter(noteData, checkifNil(keyCount, checkifNil(mania, 4)))
	if not getProperty('isCameraOnForcedPos') then
		moveCameraSection(noteType, mustPress)
		
		-- Add your own thing if you want if you have custom options for instance.
		if (whosActive.oppo or whosActive.play) --[[and getDataFromSave('your save bank or smth', 'camFollowNoteDir')]] then
			if velocity.active and camSpeedChecks.songHasStarted then
				camSpeedChecks.updateDefSpeed = false
				setProperty('cameraSpeed', velocity.defSpeed + velocity.speedAdd)
			end
			setProperty('camFollow.x', getProperty('camFollow.x') + appliedMoveForce[noteData + 1][1])
			setProperty('camFollow.y', getProperty('camFollow.y') + appliedMoveForce[noteData + 1][2])
			-- Using `cameraSpeed` here would actually so `returnDelay` a thing.
			local calculatedDelay = (1 / getProperty('cameraSpeed')) / velocity.returnDelay
			runTimer('cool cam return,' .. noteType, calculatedDelay)
		end
		-- flushSaveData('flushing your mom')
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if string.find(tag, 'cool cam return') then
		local splitContents = splitString(tag, ',')
		moveCameraSection(splitContents[2])
	end
end

---@param character string
---@param offset table.string
---@param setPos boolean
function setToCharCamPosition(character, offset, setPos)
	---@param one number
	---@param operator string
	---@param two number
	---@return number
	local function doMathStupid(one, operator, two)
		-- Fuck math, why does bf do - while dad and gf do + on x like WTF?!?!!
		one, two = checkifNil(tonumber(one), 0), checkifNil(tonumber(two), 0)
		if operator == '+' then -- Addition
			return one + two
		elseif operator == '-' then -- Subtraction
			return one - two
		elseif operator == '*' then -- Multiplication
			return one * two
		elseif operator == '/' then -- Division
			return one / two
		end
	end
	
	-- makes sure these are strings
	character = tostring(character)
	offset[1] = checkifNil(tostring(offset[1]), (focusThingy == 'boyfriend' and 'bf' or focusThingy))
	offset[2] = (offset[2] == 'original' and ((offset[1] == 'dad' and 'opponent') or (offset[1] == 'gf' and 'girlfriend') or (offset[1] == 'bf' and 'boyfriend')) or tostring(offset[2]))
	setPos = checkifNil(setPos, true)
	local tagNameThing = 'camFollow' .. (setPos and '' or 'Fake')
	
	-- set camera to then characters camera position
	setProperty(tagNameThing .. '.x', getMidpointX(character) + (offset[1] == 'dad' and 150 or offset[1] == 'gf' and 0 or offset[1] == 'bf' and -100))
	setProperty(tagNameThing .. '.y', getMidpointY(character) + (offset[1] == 'dad' and -100 or offset[1] == 'gf' and 0 or offset[1] == 'bf' and -100))
	setProperty(tagNameThing .. '.x', doMathStupid(getProperty(tagNameThing .. '.x'), offset[1] == 'bf' and '-' or '+', getProperty(character .. '.cameraPosition[0]')))
	setProperty(tagNameThing .. '.y', getProperty(tagNameThing .. '.y') + getProperty(character .. '.cameraPosition[1]'))
	
	if checkifNil(offset[2], 'none') ~= 'none' then
		setProperty(tagNameThing .. '.x', doMathStupid(getProperty(tagNameThing .. '.x'), offset[2] == 'boyfriend' and '-' or '+', getProperty(offset[2] .. 'CameraOffset[0]')))
		setProperty(tagNameThing .. '.y', getProperty(tagNameThing .. '.y') + getProperty(offset[2] .. 'CameraOffset[1]'))
	end
	if setPos then callOnLuas('onMoveCamera', {focusThingy, character, offset[2]}, true, true, {scriptName}) end
	
	-- from source on setting character camera position for reference
	--[[camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
	camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0];
	camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1];
	
	camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
	camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
	camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];
	
	camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
	camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0];
	camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];]]
end