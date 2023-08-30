local secPerBeat=0

function onCreatePost()
	secPerBeat = 60/curBpm
	setProperty('camZooming',false)
end

function onEvent(name, value1, value2)
	if name == 'UIHop' then
        defaultHUDZoom = getProperty('camHUD.zoom')
        doTweenZoom('camHUDZoomStart', "camHUD" , defaultHUDZoom + value1, 0.001,'linear')
	end
end

function onTweenCompleted(tag)
    if tag == 'camHUDZoomStart' then
       doTweenZoom('camHUDZoomEnd', "camHUD", 1, secPerBeat,'quadOut')
    end
    
end