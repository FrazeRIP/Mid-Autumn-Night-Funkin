
function onCreatePost( ... )
	--makeLuaVideoSprite("U0-ending","U0-ending",0,0)
	--debugPrint("Done")
	--addLuaSprite("U0-ending",true)
	--setObjectCamera("U0-ending","camHuD")
	--setBlendMode("U0-ending","MULTIPLY")
end


function onBeatHit( ... )
	if curBeat == 1 then
	ResumeVideoSprite("U0-ending")
	end

	if curBeat == 4 then
	PauseVideoSprite("U0-ending")
	end

	if curBeat == 8 then
	ResumeVideoSprite("U0-ending")
	end

end