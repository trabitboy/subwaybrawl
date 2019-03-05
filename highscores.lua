-- reimplement again after notepad crash .....

--change file name
hsfile="templagehs.lua"

serialize=require("ser")

maxscore=5

function defaulths()
 return {
			easy={{name='baguette',score=100},{name='man',score=100},{name='barrel',score=100},{name='force',score=100},{name='slime',score=100}},
			normal={{name='baguette',score=100},{name='man',score=100},{name='barrel',score=100},{name='force',score=100},{name='slime',score=100}},
			hard={{name='baguette',score=100},{name='man',score=100},{name='barrel',score=100},{name='force',score=100},{name='slime',score=100}},
		}
end

currenttable='easy'


function shuffletable()
	if currenttable=='easy' then
		currenttable='normal'
		return
	end
	if currenttable=='normal' then
		currenttable='hard'
		return
	end
	if currenttable=='hard' then
		currenttable='easy'
		return
	end
end


function loadscores()
 if love.filesystem.getInfo(hsfile)~=nil then
  hs=love.filesystem.load(hsfile)
  highscores=hs()
 else
  highscores=defaulths()
  
 end
 print(highscores)
 -- debug.debug()
end

loadscores()

function love.quit()
 love.filesystem.write(hsfile,serialize(highscores))
end



local timer =nil

local state=nil

--ascii code current sel
local currentcharnum=nil
local name=nil
--char num in edited string 
letternum=nil
local editedslot=nil

-- returns correct table slot or nil
function getslot(tenths)
	for i=1,maxscore 
	do
		-- print(tenths)
		-- print(hics)
		if tenths>highscores[currenttable][i].score then
			return i
		end
	end
	return nil
end

--if we need to enter slots we need to shift highscores
function shiftslots(slot,tenths,name)
	for i=maxscore,slot,-1 
	do
		highscores[currenttable][i]=highscores[currenttable][i-1]
	end
	newslot={}
	newslot.score=tenths
	newslot.name=name
	highscores[currenttable][slot]=newslot
end

--enter score finished when this is complete
local entertimer=nil


function initenterscore(tenths)
 name='aaa'
 currentcharnum=1
 letternum=1
 
 local slot=getslot(tenths)

 if slot~=nil then
	print("slot "..slot)
	print('is a high score')
	shiftslots(slot,tenths,name)
	editedslot=slot
	 state='enter'
	 entertimer=createtimer(3600)
	 updatefunc=updatescores
	 drawfunc=drawscores
 else
	print('not enough points going display')
	initdisplayscores()
 end

end

function initdisplayscores()
 timer=createtimer(1200)
 state='display'
 updatefunc=updatescores
 drawfunc=drawscores
end

function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

local function char(num)
  return string.char(string.byte("a")+num-1)
end

function drawscores()
 love.graphics.setCanvas(vscreen)
 love.graphics.clear()
 
 local current =highscores[currenttable]
 --TODO display scores of current table
love.graphics.print(currenttable,250,50)

 sy=130
 for i,s in ipairs(current)
 do
	sy=sy+20
	
	love.graphics.print(s.name,200,sy)
	love.graphics.print(s.score,320,sy)
 end 
 
 if state=='enter' then
  love.graphics.print('please enter your initials using joystick',100,20)
  love.graphics.print(name,400,20)
  love.graphics.print(char(currentcharnum),440,20)
  
 end
 
 -- love.draw(victory,0,0)
 -- love.graphics.print("YOU DID IT!",200,470)
 -- -- love.graphics.print("your score",200,300)

 -- love.graphics.print("YOU FED LIKE A PIGGIE keeping them calm !",20,500)

 -- love.graphics.print("your awesome score :",200,540)
 -- love.graphics.print(score,200,560)
 rdrvscreen()
	
end

local inhibtimer=nil


function inhibhalfsecond()
 inhibtimer=createtimer(30)

end

function updatescores()


 if state=='enter' then
 
  if entertimer~=nil then
   -- print('ticking timer')
   -- print(entertimer.time)
   entertimer:tick()
   if entertimer.finished then
    entertimer=nil
	print('going back 2 display')
	initdisplayscores()
   end
  end

 
  if inhibtimer~=nil then
   inhibtimer:tick()
   if inhibtimer.finished then
    inhibtimer=nil
   end
  end
 
  j=polljoy()
  --TODO move letter and validate letter
	if j.up or love.keyboard.isDown('w') and inhibtimer==nil then
	 print('up')
	 currentcharnum=currentcharnum+1
	 if currentcharnum>26 then
	  currentcharnum=1
	 end
	 inhibhalfsecond()
	end

	if j.down or love.keyboard.isDown('s') and inhibtimer==nil then
	 print('down')
	 currentcharnum=currentcharnum-1
	 if currentcharnum<0 then
	  currentcharnum=26
	 end
	 inhibhalfsecond()
	end
	
	
-- TODO on fire we edit name, then we push it back in highscores slot (we work in string)
	if j.mainfire or love.keyboard.isDown('j') and inhibtimer==nil then
	 print('select')
	 name=replace_char(letternum,name,char(currentcharnum))
	 highscores[currenttable][editedslot].name=name
	 letternum=letternum+1
	 if letternum>3 then
		initdisplayscores()
		return
	 end
	 inhibhalfsecond()
	end
 --TODO timer between presses 

 elseif state=='display' then
	timer:tick()
	
	if timer.finished then
	  inittitle()
	  drawfunc=drawtitle
	  updatefunc=updatetitle
	  return
	
	end
	
-- on button press go to title
	j=polljoy()
	
	if love.keyboard.isDown("return") or fingeroneid~=nil or j.mainfire~=nil then
	  inittitle()
	  drawfunc=drawtitle
	  updatefunc=updatetitle
	  return
	end

-- on time out go to title
 end
end