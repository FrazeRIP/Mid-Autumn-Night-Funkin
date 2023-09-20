local isLockCam = false
local amount = '200,400'

function onBeatHit( ... )
	
	if curBeat == 119 then
		isLockCam = true
	end
	
	if curBeat == 203 then
		isLockCam = false
	end

	if curBeat == 327 then
	
		isLockCam = true
	end
end

function onMoveCamera(focus)
	if isLockCam then
		if focus == 'boyfriend' then
			triggerEvent('Manage Cam Dir Position Lock', '', '')
		elseif focus == 'dad' then
			triggerEvent('Manage Cam Dir Position Lock', amount, amount)
		end
	end
end