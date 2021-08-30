module minp;
{This is a simple input handler for the Z80-MBC2 and V20-MBC 
 it also includes support for my GPIO Games interface which will be 
 documented elsewhare in the repo.
 
  {     MBC Expansion Port      
       GPIO GAME ADDAPTER CONN.  
     UP = U  DOWN = D lEFT = l   
        RIGHT = R  FIRE = F      
	555 TRIGGER = TRG (HIGH TRIGGERS)	
	555 EXPIRED = EXP (LOW = EXPIRED
	                   HIGH = RUNNING) 
    PASSIVE BUZZER = SND
	
        VCC   F U D L R   GND       
        |     | | | | |   |			  
       +5 1 2 3 4 5 6 7 8 GND    
        * * * * * * * * * * GPIO PORT A  
        * * * * * * * * * * GPIO PORT B  
          |           | |      
    	 EXP        TRG SND            }
 
 MIT License

Copyright (c) 2021 Dave Collins

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.}
 
type
 {$I minp.tdf}

var 
 {$I minp.vdf}

{output the ordinal value of key pressed or 0 if no key pressed }
function inkey : integer;
var
 iobyte : integer;
begin
  iobyte := inp[1];
  if iobyte = 255 then inkey := 0 else inkey := iobyte;
end;

{slightly slower but it scans the whole usable keyboard
 directional key output matches the joystick, the ordinal
 value outputed by this may overlap ctrl+key combos,
 pay attention to how you handle those interations if you
 choose to use them!}

function extinkey : integer;
var
 extinp : string[4];
 a,uinp : integer;

begin
 extinp := '';
 uinp := inkey;
 if uinp = 27 then
  begin
   for a := 1 to 4 do extinp := concat(extinp,chr(inkey));
   for a := 1 to 19 do if pos(EXTMAPPTR^[a],extinp) = 1 then uinp := a;
  end;
  extinkey := uinp;
end;

 (* read the value of PORT A, which will be the joystick interface *)
function GetJoy: integer;
begin
 out[1] := 129;    (*read Z80-MBC2 Port A store in register*)
 GetJoy := inp[0]; (* save value of Port A to function     *)
end;
modend.

