<h2><strong>MINP</strong></h2>
<h4><strong>A custom input driver for Pascal/MT+ for the MBC line of computers.</strong></h4>
<p><span style="font-weight: 400;">By D. Collins (C)2021</span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><span style="font-weight: 400;">Here is a small module for Pascal/MT+ which makes using the serial input directly on a MBC style computer very simple.&nbsp; It uses the port array which is very fast to grab data from the terminal directly, and bypases much of CPM by useing a very low level operation to do so.&nbsp; This means if you are trying to grab characters at speed for instance if you are writing a game, you do not have to write custom BIOS code to do so.&nbsp; There is a table which must be linked along with this module in order to provide access to the extended keycodes -- it's not required to use the module if you are trying to keep your code small. however the table is very small, only a few (96) bytes - plus the code to manage it which is only a few lines..</span></p>
<h4>&nbsp;</h4>
<h4><strong>Files List:</strong></h4>
<p><strong>.erl</strong><span style="font-weight: 400;"> :&nbsp; a V20-MBC 8080 Relocatable file suitable for linking, may very well work on the MBC2 but it's not been tested.</span></p>
<p><strong>.R86</strong><span style="font-weight: 400;"> : a V20-MBC 8086 Relocatable file suitable for linking. Depending on your memory map this may or may not work on other platforms, most likely will not work under dos.</span></p>
<p><strong>.def</strong><span style="font-weight: 400;"> : a define file (minp.def) must be added to the top of the source code block after your declaration block using {$I minp.def}, added in code to declare all of the procedures and functions from the module.</span></p>
<p><strong>.tdf </strong><span style="font-weight: 400;">: an internal type declaration file that adds code to declare common types.</span></p>
<p><strong>.vdf</strong><span style="font-weight: 400;"> : an internal variable declaration file that adds code to declare common variable types.</span></p>
<p><strong>.pas</strong><span style="font-weight: 400;"> : source file written in pascal.</span></p>
<p>&nbsp;</p>
<h4><strong>Usage:</strong></h4>
<p><span style="font-weight: 400;">Simply link minp.erl/.r86, and a table file (ktbl8080.erl or ktbl8086.r86) to your main source code after including the .def file after your declaration block (minp.def).&nbsp; If you do not include the table module you will get a warning about a missing symbol if you do not use appropriate switches to clear unused symbols.&nbsp; if the extended keycodes are needed you will have to define the table pointers in memory before using them by calling the kmkptrs procedure.</span></p>
<h4><strong>Symbol Explanation:</strong></h4>
<p><em><span style="font-weight: 400;">Inkey &lt;function :integer &gt; &nbsp; :&nbsp; return the ASCII value of key pressed, else return 0.</span></em></p>
<p><span style="font-weight: 400;">This returns the value of the key currently being pressed.&nbsp; I have tested it alongside bios &amp; bdos related commands, and it appears to function properly.&nbsp; This doesn&rsquo;t require a separate table file to function.</span></p>
<p>&nbsp;</p>
<p><em><span style="font-weight: 400;">Extinkey &lt;function : integer&gt; : return the ASCII Value or a value 1-16 according to the following list.</span></em></p>
<p style="text-align: center;"><strong>F1,RT,F2,LF,F3,F4,F5,DN,F6,F7,F8,F9,HOM,INS,DEL,UP,END,PGUP,PGDN</strong></p>
<p><span style="font-weight: 400;">This will return the key currently being pressed, and zero if no key -or- zero if some other escape sequence is returning from the terminal not on the list. If it is on the list it will return a value 1-16 (left to right on the above list)&nbsp; You must call </span><em><span style="font-weight: 400;">kmkptrs</span></em><span style="font-weight: 400;"> before using this command to declare the lookup table in memory. It is slightly lower as it scans the whole table until it finds the key that was sent. It does this by pulling 4 bytes from the terminal (if it detects an escape command), and then compares that sequence to an array until it finds a match. The returned values for the directional keys are the same values returned off of the custom joystick board which is part of a different project.</span></p>
<p>&nbsp;</p>
<p><em><span style="font-weight: 400;">Getjoy &lt;function :integer&gt; : returns the value of port A on the bus expander.</span></em></p>
<p><span style="font-weight: 400;">This simply returns the value of port A on the bus expander. Included is a simple schematic and a gerber of a very out-dated joystick interface.&nbsp; The Gerber is untested, and I have a much better fully working interface that will get released once I have completed porting the sound/time modules.&nbsp;</span></p>
<p>&nbsp;</p>
<p><em><span style="font-weight: 400;">Kmkptrs &lt;procedure&gt; : sets the location of the extended keymap in memory.</span></em></p>
<p><span style="font-weight: 400;">This defines the table for the extended keymap, please call this before using </span><em><span style="font-weight: 400;">extinkey</span></em><span style="font-weight: 400;">.</span></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>
<p><br /><br /></p>