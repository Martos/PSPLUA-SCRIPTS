--LuaPlayer Euphoria IntraFont Sample
--By Walar

cheese_bytes = {}

local filehandle = io.open( "DATA.BIN", "rb" )

filehandle:seek("cur", 170)
--local testapp = string.byte(filehandle:read(2))
--string.format("%x", input * 255)

table.insert(cheese_bytes, string.format("%02X", string.byte(filehandle:read(1))))
table.insert(cheese_bytes, string.format("%02X", string.byte(filehandle:read(1))))
table.insert(cheese_bytes, string.format("%02X", string.byte(filehandle:read(1))))
table.insert(cheese_bytes, string.format("%02X", string.byte(filehandle:read(1))))

filehandle:close()

print(0x00000AFF)
print(tonumber("0x00000AFF"))

local tmpString = "0x";

for i = 4, 1, -1 do
	print(cheese_bytes[i])
	tmpString = tmpString..tostring(cheese_bytes[i])
end

print(tonumber(tmpString))

black = Color.new(0, 0, 0);
gray = Color.new(180, 180, 180);
white = Color.new(255, 255, 255);
darkgray = Color.new(100, 100, 100, 128);
red = Color.new(255, 0, 0);

ifont = IntraFont.load("font.pgf", 0);
ifont:setStyle(1.0, red, darkgray, IntraFont.ALIGN_CENTER);

while true do
	--Initialize the GU
	System.draw();
	screen:clear(black);
	
	ifont:print(240, 136, ""..tonumber(tmpString));
	
	--Finish the GU and Sync
	System.endDraw();
	screen.flip();
	
	local pad = Controls.readPeek()
	
	if pad:select() then
		screen:save("screenshot.png");
	elseif pad:start() then
		break;
	end
		
end

ifont:unload();

System.quit(); -- Quit the application after the main loop breaks

