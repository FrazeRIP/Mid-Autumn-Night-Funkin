
longNoteHealthDrain = .007
noteHealthDrain = .02

function opponentNoteHit(id, direction, noteType, isSustainNote)
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
