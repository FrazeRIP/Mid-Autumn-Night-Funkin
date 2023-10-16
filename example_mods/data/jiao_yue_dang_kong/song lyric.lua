function onCreate()
	makeLuaText('getready','',1000,screenWidth/2 - 220,screenHeight/2 + 90);
	setTextSize('getready',50);
	setTextAlignment('getready','left'); 
	setTextColor('getready', 'ffffff')
	setObjectCamera('getready', 'other')
	setTextFont('getready', 'ZhengDaoCuShuTi.ttf')
	addLuaText('getready');

	makeLuaText('setlyric','',1000,screenWidth/2 - 220,screenHeight/2 + 140);
	setTextSize('setlyric',50);
	setTextAlignment('setlyric','left'); 
	setTextColor('setlyric', 'ffffff')
	setObjectCamera('setlyric', 'other')
	setTextFont('setlyric', 'ZhengDaoCuShuTi.ttf')
	addLuaText('setlyric');

	makeLuaText('sunglyric','',1000,screenWidth/2 - 220,screenHeight/2 + 140);
	setTextSize('sunglyric',50);
	setTextAlignment('sunglyric','left');
	setTextColor('sunglyric', 'b10647')
	setObjectCamera('sunglyric', 'other')
	setTextFont('sunglyric', 'ZhengDaoCuShuTi.ttf')
	addLuaText('sunglyric');
end

function onUpdate()
setProperty('sunglyric.x', getProperty('setlyric.x')) -- make sure sung text is always ontop of set text
end

function onStepHit()

	if curStep == 176 then
		setTextString('getready', '■■■')
		setTextString('setlyric','皓魄当空 宝镜东升')
	end

	if curStep == 180 then
		setTextString('getready', '■■')
	end

	if curStep == 184 then
		setTextString('getready', '■')
	end

	if curStep == 188 then
		removeLuaText('getready')
	end

	if curStep == 192 then
		setTextString('sunglyric','皓')
	end

	if curStep == 195 then
		setTextString('sunglyric','皓魄')
	end

	if curStep == 196 then
		setTextString('sunglyric','皓魄当')
	end

	if curStep == 198 then
		setTextString('sunglyric','皓魄当空')
	end

	if curStep == 200 then
		setTextString('sunglyric','皓魄当空 宝')
	end

	if curStep == 202 then
		setTextString('sunglyric','皓魄当空 宝镜')
	end

	if curStep == 204 then
		setTextString('sunglyric','皓魄当空 宝镜东')
	end

	if curStep == 206 then
		setTextString('sunglyric','皓魄当空 宝镜东升')
	end

	if curStep == 208 then
		setTextString('setlyric','云间仙籁 寂无声')
		setTextString('sunglyric', '云')
	end

	if curStep == 211 then
		setTextString('sunglyric','云间')
	end

	if curStep == 212 then
		setTextString('sunglyric','云间仙')
	end

	if curStep == 214 then
		setTextString('sunglyric','云间仙籁')
	end

	if curStep == 216 then
		setTextString('sunglyric','云间仙籁 寂')
	end

	if curStep == 218 then
		setTextString('sunglyric','云间仙籁 寂无')
	end

	if curStep == 220 then
		setTextString('sunglyric','云间仙籁 寂无声')
	end

	if curStep == 224 then
		setTextString('setlyric','清风徐来 飞镜重磨')
		setTextString('sunglyric', '清')
	end

	if curStep == 227 then
		setTextString('sunglyric','清风')
	end

	if curStep == 228 then
		setTextString('sunglyric','清风徐')
	end

	if curStep == 230 then
		setTextString('sunglyric','清风徐来')
	end

	if curStep == 232 then
		setTextString('sunglyric','清风徐来 飞')
	end

	if curStep == 234 then
		setTextString('sunglyric','清风徐来 飞镜')
	end

	if curStep == 236 then
		setTextString('sunglyric','清风徐来 飞镜重')
	end

	if curStep == 238 then
		setTextString('sunglyric','清风徐来 飞镜重磨')
	end

	if curStep == 240 then
		setTextString('setlyric','今夜月明 共赏金波')
		setTextString('sunglyric', '今')
	end

	if curStep == 243 then
		setTextString('sunglyric','今夜')
	end

	if curStep == 244 then
		setTextString('sunglyric','今夜月')
	end

	if curStep == 246 then
		setTextString('sunglyric','今夜月明')
	end

	if curStep == 248 then
		setTextString('sunglyric','今夜月明 共')
	end

	if curStep == 250 then
		setTextString('sunglyric','今夜月明 共赏')
	end

	if curStep == 252 then
		setTextString('sunglyric','今夜月明 共赏金')
	end

	if curStep == 254 then
		setTextString('sunglyric','今夜月明 共赏金波')
	end

	if curStep == 256 then
		setTextColor('sunglyric', '55c3ff')
		setTextString('setlyric','金饼飘香 阖家团圆')
		setTextString('sunglyric', '金')
	end

	if curStep == 259 then
		setTextString('sunglyric','金饼')
	end

	if curStep == 260 then
		setTextString('sunglyric','金饼飘')
	end

	if curStep == 262 then
		setTextString('sunglyric','金饼飘香')
	end

	if curStep == 264 then
		setTextString('sunglyric','金饼飘香 阖')
	end

	if curStep == 266 then
		setTextString('sunglyric','金饼飘香 阖家')
	end

	if curStep == 268 then
		setTextString('sunglyric','金饼飘香 阖家团')
	end

	if curStep == 270 then
		setTextString('sunglyric','金饼飘香 阖家团圆')
	end

	if curStep == 272 then
		setTextString('setlyric','秋空玉盘 一轮满')
		setTextString('sunglyric', '秋')
	end

	if curStep == 275 then
		setTextString('sunglyric','秋空')
	end

	if curStep == 276 then
		setTextString('sunglyric','秋空玉')
	end

	if curStep == 278 then
		setTextString('sunglyric','秋空玉盘')
	end

	if curStep == 280 then
		setTextString('sunglyric','秋空玉盘 一')
	end

	if curStep == 282 then
		setTextString('sunglyric','秋空玉盘 一轮')
	end

	if curStep == 284 then
		setTextString('sunglyric','秋空玉盘 一轮满')
	end

	if curStep == 288 then
		setTextString('setlyric','中秋佳节 举杯邀月')
		setTextString('sunglyric', '中')
	end

	if curStep == 291 then
		setTextString('sunglyric','中秋')
	end

	if curStep == 292 then
		setTextString('sunglyric','中秋佳')
	end

	if curStep == 294 then
		setTextString('sunglyric','中秋佳节')
	end

	if curStep == 296 then
		setTextString('sunglyric','中秋佳节 举')
	end

	if curStep == 298 then
		setTextString('sunglyric','中秋佳节 举杯')
	end

	if curStep == 300 then
		setTextString('sunglyric','中秋佳节 举杯邀')
	end

	if curStep == 302 then
		setTextString('sunglyric','中秋佳节 举杯邀月')
	end

	if curStep == 304 then
		setTextString('setlyric','桂花未孤 正值良夜')
		setTextString('sunglyric', '桂')
	end

	if curStep == 307 then
		setTextString('sunglyric','桂花')
	end

	if curStep == 308 then
		setTextString('sunglyric','桂花未')
	end

	if curStep == 310 then
		setTextString('sunglyric','桂花未孤')
	end

	if curStep == 312 then
		setTextString('sunglyric','桂花未孤 正')
	end

	if curStep == 314 then
		setTextString('sunglyric','桂花未孤 正值')
	end

	if curStep == 316 then
		setTextString('sunglyric','桂花未孤 正值良')
	end

	if curStep == 318 then
		setTextString('sunglyric','桂花未孤 正值良夜')
	end

	if curStep == 320 then
		setTextColor('sunglyric', 'b10647')
		setProperty('setlyric.x', screenWidth/2 - 300)
		setTextString('setlyric','皎月当空 又怎能 悯人悲秋')
		setTextString('sunglyric', '皎')
	end

	if curStep == 323 then
		setTextString('sunglyric','皎月')
	end

	if curStep == 326 then
		setTextString('sunglyric','皎月当')
	end

	if curStep == 328 then
		setTextString('sunglyric','皎月当空')
	end

	if curStep == 336 then
		setTextString('sunglyric','皎月当空 又')
	end

	if curStep == 339 then
		setTextString('sunglyric','皎月当空 又怎')
	end

	if curStep == 342 then
		setTextString('sunglyric','皎月当空 又怎能')
	end

	if curStep == 344 then
		setTextString('sunglyric','皎月当空 又怎能 悯')
	end

	if curStep == 346 then
		setTextString('sunglyric','皎月当空 又怎能 悯人')
	end

	if curStep == 348 then
		setTextString('sunglyric','皎月当空 又怎能 悯人悲')
	end

	if curStep == 350 then
		setTextString('sunglyric','皎月当空 又怎能 悯人悲秋')
	end

	if curStep == 352 then
		setProperty('setlyric.x', screenWidth/2 - 230)
		setTextString('setlyric','清光凝露 秋分 赏酒')
		setTextString('sunglyric', '清')
	end

	if curStep == 355 then
		setTextString('sunglyric','清光')
	end

	if curStep == 358 then
		setTextString('sunglyric','清光凝')
	end

	if curStep == 360 then
		setTextString('sunglyric','清光凝露')
	end

	if curStep == 368 then
		setTextString('sunglyric','清光凝露 秋')
	end

	if curStep == 372 then
		setTextString('sunglyric','清光凝露 秋分')
	end

	if curStep == 376 then
		setTextString('sunglyric','清光凝露 秋分 赏')
	end

	if curStep == 380 then
		setTextString('sunglyric','清光凝露 秋分 赏酒')
	end

	if curStep == 384 then
		setTextColor('sunglyric', '55c3ff')
		setProperty('setlyric.x', screenWidth/2 - 300)
		setTextString('setlyric','把酒言欢 问素娥 歌声悠悠')
		setTextString('sunglyric', '把')
	end

	if curStep == 387 then
		setTextString('sunglyric','把酒')
	end

	if curStep == 390 then
		setTextString('sunglyric','把酒言')
	end

	if curStep == 392 then
		setTextString('sunglyric','把酒言欢')
	end

	if curStep == 400 then
		setTextString('sunglyric','把酒言欢 问')
	end

	if curStep == 403 then
		setTextString('sunglyric','把酒言欢 问素')
	end

	if curStep == 406 then
		setTextString('sunglyric','把酒言欢 问素娥')
	end

	if curStep == 408 then
		setTextString('sunglyric','把酒言欢 问素娥 歌')
	end

	if curStep == 410 then
		setTextString('sunglyric','把酒言欢 问素娥 歌声')
	end

	if curStep == 412 then
		setTextString('sunglyric','把酒言欢 问素娥 歌声悠')
	end

	if curStep == 414 then
		setTextString('sunglyric','把酒言欢 问素娥 歌声悠悠')
	end

	if curStep == 416 then
		setProperty('setlyric.x', screenWidth/2 - 230)
		setTextString('setlyric','难得良宵 共奏 歌舞')
		setTextString('sunglyric', '难')
	end

	if curStep == 419 then
		setTextString('sunglyric','难得')
	end

	if curStep == 422 then
		setTextString('sunglyric','难得良')
	end

	if curStep == 424 then
		setTextString('sunglyric','难得良宵')
	end

	if curStep == 432 then
		setTextString('sunglyric','难得良宵 共')
	end

	if curStep == 436 then
		setTextString('sunglyric','难得良宵 共奏')
	end

	if curStep == 440 then
		setTextString('sunglyric','难得良宵 共奏 歌')
	end

	if curStep == 444 then
		setTextString('sunglyric','难得良宵 共奏 歌舞')
	end

	if curStep == 448 then
		doTweenAlpha('bye1','setlyric',0,2,'linear')
		doTweenAlpha('bye2','sunglyric',0,2,'linear')
	end

end

function noteMiss(id, direction, noteType, isSustainNote)
	if mustHitSection and curStep >= 255 then
		setTextColor('sunglyric', '758893')
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mustHitSection and curStep >= 255 then
		setTextColor('sunglyric', '55c3ff')
	end
end