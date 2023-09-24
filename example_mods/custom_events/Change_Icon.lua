--got it from psych discord, the user already deleted its account :(

function RGBToHexConverter(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function VectoHex(r, g, b)
    local hex = {
        math.floor(r * 255),
        math.floor(g * 255),
        math.floor(b * 255)
    }
	local newcolor = string.format('%.2x%.2x%.2x', hex[1], hex[2], hex[3])
    return newcolor
end

function Split(s, delimiter)
	-- cool stuff Unholy
	local result = {}
	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, stringTrim(tostring(match)))
	end
	return result
end

function onEvent(n, v1, v2)
    if n == 'Change Icon' or n == 'Change_Icon' then --discord shit :skull:
		local tableee = Split(v1, ', ')
		local tableee = Split(v1, ',')
		local tableee2 = Split(v2, ', ')
		local tableee2 = Split(v2, ',')

		icon = tableee[1]
		name = tableee[2]
		color = tableee[3]

		valer = tableee2[1]
		valeg = tableee2[2]
		valeb = tableee2[3]

        tableee[1] = tonumber(tableee[1]);
        tableee[2] = tonumber(tableee[2]);
        tableee[3] = tonumber(tableee[3]);

		tableee2[1] = tonumber(tableee2[1]);
        tableee2[2] = tonumber(tableee2[2]);
        tableee2[3] = tonumber(tableee2[3]);

        runHaxeCode([[
            game.iconP]] .. icon .. [[.changeIcon(']] .. name .. [[');
        ]])

		if icon == '1' then
			if color == 'Hex' then
				setHealthBarColors(RGBToHexConverter(getProperty("dad.healthColorArray")), getColorFromHex(valer))
			elseif color == 'RGB' then
				setHealthBarColors(RGBToHexConverter(getProperty("dad.healthColorArray")), RGBToHexConverter({valer, valeg, valer}))
			elseif color == 'VEC' then
				setHealthBarColors(RGBToHexConverter(getProperty("dad.healthColorArray")), VectoHex(valer, valeg, valer))
			end
		elseif icon == '2' then
			if color == 'Hex' then
				setHealthBarColors(getColorFromHex(valer), RGBToHexConverter(getProperty("boyfriend.healthColorArray")))
			elseif color == 'RGB' then
				setHealthBarColors(RGBToHexConverter({valer, valeg, valer}), RGBToHexConverter(getProperty("boyfriend.healthColorArray")))
			elseif color == 'VEC' then
				setHealthBarColors(VectoHex(valer, valeg, valer), RGBToHexConverter(getProperty("boyfriend.healthColorArray")))
			end
		end
    end
end