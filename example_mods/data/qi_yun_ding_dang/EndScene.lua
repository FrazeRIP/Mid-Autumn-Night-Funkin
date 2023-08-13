
function onCreatePost( ... )
	makeLuaVideoSprite("U0-ending","U0-ending",0,0)
	addLuaSprite("U0-ending",true)
	setObjectCamera("U0-ending","camOther")
	
	doTweenAlpha("U0-endingA","U0-ending",0,0.0001,'cubeOut')
end


function onBeatHit( ... )

	if curBeat == 328 then
		doTweenAlpha("hudA","camHUD",0,2,'cubeOut')
	end

	if curBeat == 336 then
		doTweenAlpha("U0-endingA","U0-ending",1,1,'cubeOut')
		ResumeVideoSprite("U0-ending")
	end
end

function onResume( ... )
	if curBeat <= 336 then
		PauseVideoSprite("U0-ending")
	end
end

function onPause( ... )
	if curBeat <= 336 then
		ResumeVideoSprite("U0-ending")
	end
end
