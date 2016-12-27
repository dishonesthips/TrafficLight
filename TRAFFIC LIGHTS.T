%By Borna Houmani and Charles Yu, Team Red Means Go
%Ian and Mason, The Three Musketeers, came up with the revolutionary aesthetic design of rounded rectangles. This design would go on to change traffic lights 4ever
import GUI

%Prepares fonts and other variables required for the program
var arialB, arialBs : int
arialB := Font.New ("arial bold:20")
arialBs := Font.New ("arial bold:15")
var x, y, button : int
var count : real := 0
var lim : real := 1.5
%Sets screen dimensions
setscreen ("graphics:600;500")

%Draws text that labels the lights and the button
Draw.Text ("North/South", 28, 455, arialB, black)
Draw.Text ("East/West", 425, 455, arialB, black)

%Draws rounded rectangle for n/s traffic light
drawfillbox (30, 450, 190, 10, 20)
drawfillbox (10, 430, 210, 30, 20)
drawfillarc (30, 30, 20, 20, 180, 270, 20)
drawfillarc (190, 30, 20, 20, 270, 360, 20)
drawfillarc (190, 430, 20, 20, 0, 90, 20)
drawfillarc (30, 430, 20, 20, 90, 180, 20)

%Draws rounded rectangle for e/w traffic light
drawfillbox (410, 450, 570, 10, 20)
drawfillbox (390, 430, 590, 30, 20)
drawfillarc (410, 30, 20, 20, 180, 270, 20)
drawfillarc (570, 30, 20, 20, 270, 360, 20)
drawfillarc (570, 430, 20, 20, 0, 90, 20)
drawfillarc (410, 430, 20, 20, 90, 180, 20)

%Draws all 6 lights in idle position (off)
drawfilloval (110, 370, 60, 60, 112) % RED
drawfilloval (110, 230, 60, 60, 116) % YELLOW
drawfilloval (110, 90, 60, 60, 191)  % GREEN
drawfilloval (490, 370, 60, 60, 112) % RED
drawfilloval (490, 230, 60, 60, 116) % YELLOW
drawfilloval (490, 90, 60, 60, 191)  % GREEN

%parallelput (2#00000000)

%Draws the start button
drawfillbox (230, 210, 370, 290, 105)
Draw.Text ("START", 255, 240, arialB, white)
var chars : array char of boolean

%Loop to check mouse before the simulation begins (check for press start button)
loop
    %Check mouse and keyboard properties
    mousewhere (x, y, button)
    Input.KeyDown (chars)
    %If mouse is pressed and the position is anywhere on top of the button (AKA they are pressing the button) then
    if (button = 1 and x >= 230 and x <= 370 and y >= 210 and y <= 290) or chars (' ') then
	%Erase button
	drawfillbox (230, 210, 370, 290, white)
	%Add speed modifier buttons
	Draw.Text ("SPEED", 265, 420, arialBs, black)
	drawfillbox (275, 410, 321, 380, 42)
	drawfillbox (275, 370, 321, 340, 54)
	Draw.Text ("+", 291, 385, arialB, white)
	Draw.Text ("-", 294, 348, arialB, white)
	%Add cross button
	drawfillbox (250, 10, 350, 50, 17)
	Draw.Text ("CROSS", 265, 23, arialBs, white)
	%Add crosswalk signals
	drawfilloval (300, 230, 40, 40, 12)
	drawfilloval (300, 140, 40, 40, 191)
	Draw.Text ("CROSSWALK", 235, 280, arialBs, black)
	%Main program loop. Once start button is pressed, program never leaves this loop
	loop
	    %Continue checking mouse after start button is pressed
	    mousewhere (x, y, button)

	    %If the increase speed button is pressed
	    if button = 1 and x >= 275 and x <= 321 and y >= 380 and y <= 410 then
		%Check that it's not max speed. If it isn't then
		if lim > .5 then
		    %Increase speed
		    lim := lim - .5
		    %Reset entire system
		    count := 0
		    drawfilloval (110, 370, 60, 60, 12)  % RED
		    drawfilloval (110, 230, 60, 60, 116) % YELLOW
		    drawfilloval (110, 90, 60, 60, 191)  % GREEN
		    drawfilloval (490, 370, 60, 60, 12)  % RED
		    drawfilloval (490, 230, 60, 60, 116) % YELLOW
		    drawfilloval (490, 90, 60, 60, 191)  % GREEN
		    drawfilloval (300, 230, 40, 40, 12)  % CROSS RED
		    drawfilloval (300, 140, 40, 40, 191) % CROSS GREEN
		    %parallelput (2#01001001)
		    delay (500)
		end if
		%If the decrease speed button is pressed
	    elsif button = 1 and x >= 275 and x <= 321 and y >= 340 and y <= 370 then
		%Decrease speed
		lim := lim + .5
		%Reset entire system
		count := 0
		drawfilloval (110, 370, 60, 60, 12)  % RED
		drawfilloval (110, 230, 60, 60, 116) % YELLOW
		drawfilloval (110, 90, 60, 60, 191)  % GREEN
		drawfilloval (490, 370, 60, 60, 12)  % RED
		drawfilloval (490, 230, 60, 60, 116) % YELLOW
		drawfilloval (490, 90, 60, 60, 191)  % GREEN
		drawfilloval (300, 230, 40, 40, 12)  % CROSS RED
		drawfilloval (300, 140, 40, 40, 191) % CROSS GREEN
		%parallelput (2#01001001)
		delay (500)
	    end if

	    %If the counter is over the limit
	    if count > 7001 * lim then
		%Reset counter
		count := 0
	    end if
	    %Add to count
	    count := count + 1
	    locate (1, 1)
	    put count
	    %If the cross button is pressed
	    if button = 1 and x >= 250 and x <= 350 and y >= 10 and y <= 50 then
		%If traffic is in the state of the n/s line being yellow or green
		if count >= 4001 * lim and count <= 7000 * lim then
		    %N/S YELLOW, E/W RED, CROSS RED
		    drawfilloval (110, 230, 60, 60, 14)
		    drawfilloval (110, 90, 60, 60, 191)
		    %parallelput (2#01001010)
		    delay (4000)
		    drawfilloval (110, 230, 60, 60, 116)
		    %N/S RED, E/W GREEN
		    drawfilloval (110, 370, 60, 60, 12)
		    drawfilloval (490, 90, 60, 60, 10)
		    drawfilloval (490, 370, 60, 60, 112)
		    %CROSS GREEN
		    drawfilloval (300, 230, 40, 40, 112)
		    drawfilloval (300, 140, 40, 40, 10)
		    %parallelput (2#10100001)
		    delay (12000)
		    %CROSS FLASHES RED, GREEN OFF
		    drawfilloval (300, 230, 40, 40, 12)
		    drawfilloval (300, 140, 40, 40, 191)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    %Changes the count to continue with yellow light
		    count := 2501 * lim
		    %If it is in the state of both red lights
		elsif count >= 1 * lim and count <= 500 * lim then
		    %N/S RED, E/W GREEN
		    drawfilloval (110, 370, 60, 60, 12)
		    drawfilloval (490, 90, 60, 60, 10)
		    drawfilloval (490, 370, 60, 60, 112)
		    %CROSS GREEN
		    drawfilloval (300, 230, 40, 40, 112)
		    drawfilloval (300, 140, 40, 40, 10)
		    %parallelput (2#10100001)
		    delay (12000)
		    %CROSS FLASHES RED, GREEN OFF
		    drawfilloval (300, 230, 40, 40, 12)
		    drawfilloval (300, 140, 40, 40, 191)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    %Changes the count to continue with yellow light
		    count := 2501 * lim
		elsif count >= 501 * lim and count <= 2500 * lim then
		    %CROSS GREEN
		    drawfilloval (300, 230, 40, 40, 112)
		    drawfilloval (300, 140, 40, 40, 10)
		    %parallelput (2#10100001)
		    delay (12000)
		    %CROSS FLASHES RED, GREEN OFF
		    drawfilloval (300, 230, 40, 40, 12)
		    drawfilloval (300, 140, 40, 40, 191)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 112)
		    %parallelput (2#00100001)
		    delay (500)
		    drawfilloval (300, 230, 40, 40, 12)
		    %parallelput (2#01100001)
		    %Changes the count to continue with yellow light
		    count := 2501 * lim
		end if
	    end if
	    if count >= 1 * lim and count <= 500 * lim then
		%N/S RED, E/W RED
		drawfilloval (110, 370, 60, 60, 12)
		drawfilloval (490, 370, 60, 60, 12)
		%cross
		drawfilloval (300, 230, 40, 40, 12)
		drawfilloval (300, 140, 40, 40, 191)
		%parallelput (2#01001001)
	    elsif count >= 501 * lim and count <= 2500 * lim then
		%N/S RED, E/W GREEN
		drawfilloval (490, 90, 60, 60, 10)
		drawfilloval (490, 370, 60, 60, 112)
		%cross
		drawfilloval (300, 230, 40, 40, 112)
		drawfilloval (300, 140, 40, 40, 10)
		%parallelput (2#10100001)
	    elsif count >= 2501 * lim and count <= 3500 * lim then
		%N/S RED, E/W YELLOW
		drawfilloval (490, 230, 60, 60, 14)
		drawfilloval (490, 90, 60, 60, 191)
		%cross
		drawfilloval (300, 230, 40, 40, 12)
		drawfilloval (300, 140, 40, 40, 191)
		%parallelput (2#01010001)
	    elsif count >= 3501 * lim and count <= 4000 * lim then
		%N/S RED, E/W RED
		drawfilloval (490, 370, 60, 60, 12)
		drawfilloval (490, 230, 60, 60, 116)
		%cross
		drawfilloval (300, 230, 40, 40, 12)
		drawfilloval (300, 140, 40, 40, 191)
		%parallelput (2#01001001)
	    elsif count >= 4001 * lim and count <= 6000 * lim then
		%N/S GREEN, E/W RED
		drawfilloval (110, 90, 60, 60, 10)
		drawfilloval (110, 370, 60, 60, 112)
		%cross
		drawfilloval (300, 230, 40, 40, 12)
		drawfilloval (300, 140, 40, 40, 191)
		%parallelput (2#01001100)
	    elsif count >= 6001 * lim and count <= 7000 * lim then
		%N/S YELLOW, E/W RED
		drawfilloval (110, 230, 60, 60, 14)
		drawfilloval (110, 90, 60, 60, 191)
		%cross
		drawfilloval (300, 230, 40, 40, 12)
		drawfilloval (300, 140, 40, 40, 191)
		%parallelput(2#01001010)
	    else
		drawfilloval (110, 230, 60, 60, 116)
	    end if
	end loop
    end if
end loop

%drawfilloval(110,370,60,60,12)  %RED
%drawfilloval(110,230,60,60,14)  %YELLOW
%drawfilloval(110,90,60,60,10)   %GREEN
%drawfilloval(490,370,60,60,12)  %RED
%drawfilloval(490,230,60,60,14)  %YELLOW
%drawfilloval(490,90,60,60,10)   %GREEN
