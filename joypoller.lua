
-- local lastbutton = "none"
 
-- function love.gamepadpressed(joystick, button)
    -- lastbutton = button
-- end
 
-- function love.draw()
    -- love.graphics.print("Last gamepad button pressed: "..lastbutton, 10, 10)
-- end


function initjoy()
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
 
end
 
function polljoy()

	ret={}

    if not joystick then return ret end
	-- print(joystick:getAxis(1))
	if joystick:getAxis(1)>0.1 then
	 -- print ("joy right")
	 ret.right=true
	end
	if joystick:getAxis(1)<-0.1 then
	 -- print ("joy left")
	 ret.left=true
	end
	-- print(joystick:getAxis(2))
	if joystick:getAxis(2)>0.1 then
	 -- print ("joy down")
	 ret.down=true
	end
	if joystick:getAxis(2)<-0.1 then
	 -- print ("joy up")
	 ret.up=true

	end
 
	-- if joystick:isDown(1) then
	 -- print("1 d")
	-- end

	if joystick:isGamepadDown("a") then
	 print("a")
	 ret.mainfire=true
	end
	if joystick:isGamepadDown("b") then
	 print("b")
	 ret.mainfire=true
	end
	if joystick:isGamepadDown("x") then
	 print("x")
	 ret.mainfire=true
	end
	if joystick:isGamepadDown("y") then
	 print("y")
	 ret.mainfire=true
	end
	if joystick:isGamepadDown("leftshoulder") then
	 print("leftshoulder")
	 ret.mainfire=true
	end
	-- if joystick:isGamepadDown("leftbumper") then
	 -- print("left bumper")
	 -- ret.mainfire=true
	-- end
	if joystick:isGamepadDown("rightshoulder") then
	 print("right shoulder")
	 ret.mainfire=true
	end
	-- if joystick:isGamepadDown("rightbumper") then
	 -- print("right bumper")
	 -- ret.mainfire=true
	-- end

	
	if joystick:isGamepadDown("start") then
	 -- print("start")
	 ret.start=true
	end

	
    if joystick:isGamepadDown("dpleft") then
        -- position.x = position.x - speed * dt
	 ret.left=true
    elseif joystick:isGamepadDown("dpright") then
        -- position.x = position.x + speed * dt
	 ret.right=true
    end
 
    if joystick:isGamepadDown("dpup") then
        -- position.y = position.y - speed * dt
	 ret.up=true
    elseif joystick:isGamepadDown("dpdown") then
        -- position.y = position.y + speed * dt
	 ret.down=true
    end
	
	return ret
end
 
-- function love.draw()
    -- love.graphics.circle("fill", position.x, position.y, 50)
    -- love.graphics.print("Last gamepad button pressed: "..lastbutton, 10, 10)
-- end