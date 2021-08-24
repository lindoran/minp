module kt8080;
{this is the extended keymap table for minp, there are two
 modules one for the 8080 and one for the 8086, you need to 
 link one in for minp to work. 
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
SOFTWARE.
 }

type
mapType = array[1..19] of string[4];
 
var 
EXTMAPPTR : ^maptype;

{ scan codes are in order of:  
 F1,RT,F2,LF,F3,F4,F5,DN,F6,F7,F8,F9,HOM,INS,DEL,UP,END,PGUP,PGDN 
 it is done this way so that the directional keys produce the same 
 values as the direction indicators on a 4 way joystick using my 
 GPIO Games interface. in hind site it was a fairly shortsited 
 choice but I was learning as I went.}
 
PROCEDURE EXTMAP;
BEGIN
     INLINE ( 3 / '[[A' / 0 / 2 / '[C' / 0 / 0 / 3 / '[[B' / 0 / 
              2 / '[D'  / 0 / 0 / 3 / '[[C' / 0 / 3 / '[[D'/ 0 / 
              3 / '[[E' / 0 / 2 / '[B' / 0 / 0 / 4 / '[17~'/ 
              4 / '[18~'/ 4 /'[19~'/ 4 /'[20~'/ 3 / '[1~' / 0 / 
              3 / '[2~' / 0 / 3 / '[3~' / 0 / 2 / '[A' / 0 / 0 /
              3 / '[4~' / 0 / 3 / '[5~'/ 0 / 3 / '[6~' / 0);
END;

{make pointer for extended keymap table, seems wastefull in 8080 but much 
 more complex in 8086}
 
PROCEDURE kmkptrs;
begin
 EXTMAPPTR := addr(EXTMAP);
end;

modend.

