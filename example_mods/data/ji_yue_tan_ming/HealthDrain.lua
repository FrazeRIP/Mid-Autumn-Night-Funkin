
longNoteHealthDrain = .008
noteHealthDrain = .025

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curStep <=477 then
		return
	end



	 health = getProperty('health')
	 
	 if isSustainNote == true then
		if getProperty('health')>0.02 then
		setProperty('health', health- longNoteHealthDrain)
		end
		else
		if getProperty('health')>0.025 then
		setProperty('health', health- noteHealthDrain)
		end
	 end
end
