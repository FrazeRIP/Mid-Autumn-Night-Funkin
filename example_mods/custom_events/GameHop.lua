local secPerBeat=0
function onCreatePost()
	secPerBeat = 60/curBpm
	setProperty('camZooming',false)
end

function onEvent(name, value1, value2)
    if name == 'GameHop' then
        defaultZoom = getProperty('camGame.zoom')
        doTweenZoom('camGameZoomStart', "camGame" , defaultZoom + value1, 0.001,'linear')
    end

end

function onTweenCompleted(tag)
    
    if tag == 'camGameZoomStart' then
        defaultZoom = getProperty('defaultCamZoom')
        doTweenZoom('camGameZoomEnd', "camGame", defaultZoom,  secPerBeat,'quadOut')
    end
end