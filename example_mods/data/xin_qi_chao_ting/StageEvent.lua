
function onCreatePost( ... )
	doTweenX('paolaSX', 'dad.scale', .9, .00001)
	doTweenY('paolaSY', 'dad.scale', .9, .00001)
	doTweenX('bfSX', 'boyfriend.scale', .6, .00001)
	doTweenY('bfSY', 'boyfriend.scale', .6,.00001)
	doTweenX('gfSX', 'gf.scale', .7, .00001)
	doTweenY('gfSY', 'gf.scale', .7, .00001)
	
	--doTweenY('bfPY', 'boyfriend',300, .00001)

	setProperty('gf.visible',false)
end