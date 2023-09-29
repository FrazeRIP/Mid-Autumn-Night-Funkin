function onStepHit( ... )
	if curStep == 106 then
		Zella()
	end

	if curStep == 204 then
		IS()
	end

	if curStep == 332 then
		GA()
	end

	if curStep == 516 then
		IS()
	end

	if curStep == 536 then
		Zella()
	end

	if curStep == 606 then
		GA()
	end

	if curStep == 736 then
		Zella()
	end

	if curStep == 796 then
		IS()
	end

	if curStep == 858 then
		GA()
	end

	if curStep == 885 then
		Zella()
	end

	if curStep == 928 then
		GA()
	end

	if curStep == 992 then
		IS()
	end

	if curStep == 1196 then
		Zella()
	end
	if curStep == 1232 then
		IS()
	end
end


function Zella()
	setHealthBarColors('EBC883', '55C3E1')
    runHaxeCode([[game.iconP2.changeIcon('Zella');]])
end

function GA()
	setHealthBarColors('85DFEB', '55C3E1')
    runHaxeCode([[game.iconP2.changeIcon('GA');]])
end

function IS()
	setHealthBarColors('D75D5D', '55C3E1')
    runHaxeCode([[game.iconP2.changeIcon('IS');]])
end

