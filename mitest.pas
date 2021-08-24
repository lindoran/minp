program mitest;

var 
a,b,c :integer;

{$I minp.def}


begin
 kmkptrs;
 write(chr(27),'[?25l');
 writeln;
 write(chr(27),'[s');
 a:=0;
 b:=1;
 while (a <> 32) do 
  begin
    a := extinkey;
    if a > 0 then begin
     write(chr(27),'[u   ');
     write(chr(27),'[u',a);
    end;
  end;
 writeln(chr(27),'[?25h');
end.

