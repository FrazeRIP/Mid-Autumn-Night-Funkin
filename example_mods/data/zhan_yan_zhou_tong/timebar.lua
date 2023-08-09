--made by KyoEnomoto (discord : kyo_loves_cats)
--https://gyazo.com/0484ca9ba2f8956f6fc52b887faa66e0
-- D-Side Time Bar Offset Thing v.1.2
local timeRemoved = 85 --how much time of the song is removed to make a fake duration of the song, so it **looks** short (use seconds as a format), this value cannot be bigger than the song's actual length
local stopFakeBar = 1425 --the current StepHit in which u want the bar to go back to normal (the curStep?...), this will work if u are trying to make it go back before the fakeTime ends, otherwise it will automatically go back when time goes to 0
local timeBarRightC = '000000' --change what color u want on left bar (hex format)
local timeBarLeftC = 'FFFFFF'  --change what color u want on right bar (hex format)
local timeTxtColor = 'FFFFFF' --change what color u want of text (hex format)

--no touching
local offsetTime = timeRemoved*1000
local keepDoing = true
local fakeTime = true
local ogTime = false
function onCreatePost()	
   if timeBarType ~= 'Disabled' and fakeTime then
      setTimeBarColors(timeBarLeftC, timeBarRightC)
      setTextColor('timeTxt', timeTxtColor) 

      makeLuaSprite('fakeTimeBar', '', getProperty('timeBar.x'), getProperty('timeBar.y'))
      makeGraphic('fakeTimeBar', 1, getProperty('timeBar.height'), timeBarLeftC)
      setObjectCamera('fakeTimeBar', 'hud')
      setObjectOrder('fakeTimeBar', getObjectOrder('timeBar')+1)
      addLuaSprite('fakeTimeBar', false)

      if timeBarType == 'Time Left' then 
         setProperty('timeTxt.visible', false)
         makeLuaText('timeFake', '', getTextWidth('timeTxt'), getProperty('timeTxt.x'), getProperty('timeTxt.y'))
         setTextSize('timeFake', getTextSize('timeTxt'))
         setTextColor('timeFake', timeTxtColor)
         addLuaText('timeFake')
      end
   end
end

function onUpdatePost(elapsed)
   local newSongPercent = (getSongPosition()/(songLength-offsetTime)) 
   if curStep > 0 then
      if getProperty('fakeTimeBar.width') < (getProperty('timeBar.width')-9) then 
         if fakeTime and luaSpriteExists('fakeTimeBar') then
            makeGraphic('fakeTimeBar', (getProperty('timeBar.width')-9)*newSongPercent, getProperty('timeBar.height'), timeBarLeftC)
            if timeBarType == 'Time Left' then 
               setTextString('timeFake', formatTime((songLength-offsetTime)-getSongPosition()))
            end   
         end
      else  
         keepDoing = false  
      end
   end 
   if curStep == stopFakeBar and keepDoing then 
      keepDoing = false
   end   
   if not keepDoing then
      if offsetTime >= 1000 then
         offsetTime = offsetTime-1000
      else
         offsetTime = 0  
         fakeTime = false 
         ogTime = true
      end 
      if fakeTime and luaSpriteExists('fakeTimeBar') then  
         makeGraphic('fakeTimeBar', (getProperty('timeBar.width')-9)*newSongPercent, getProperty('timeBar.height'), timeBarLeftC)
         if timeBarType == 'Time Left' then 
            setTextString('timeFake', formatTime((songLength-offsetTime)-getSongPosition()))
         end 
      end 
      if ogTime and luaSpriteExists('fakeTimeBar') then  
         setProperty('timeTxt.visible', true)
         removeLuaText('timeFake', true)
         removeLuaSprite('fakeTimeBar', true)
      end    
   end
   if luaSpriteExists('fakeTimeBar') then
      setProperty('fakeTimeBar.alpha', getProperty('timeBar.alpha')) 
      setProperty('timeFake.alpha', getProperty('timeTxt.alpha'))  
   end
end

function formatTime(millisecond)
   local seconds = math.floor(millisecond / 1000)

   return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)  
end