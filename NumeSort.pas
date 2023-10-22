program sort;
  // fete sufics la sou na
function estefata(input: string): Boolean;
begin
  
  if (((input[input.Length - 1] = 't') or (input[input.Length - 1] = 'n') or (input[input.Length - 1] = 't')) and (input[input.Length] = 'a')) then
    estefata := True
  else
    estefata := False;
end;

function swap(input1, input2: string): Boolean;
var
  i: integer;
begin
  for i := 1 to (Min(input1.Length, input2.Length)) do
  begin
    if (Ord(input1[i]) < Ord(input2[i])) then
    begin
      swap := True;
      Exit; // Exit the function early if the condition is met
    end
    else if Ord(input1[i]) > Ord(input2[i]) then
    begin
      swap := False;
      Exit; // Exit the function early if the condition is met
    end;
  end;

  // If all characters are equal, compare the lengths
  if input1.Length < input2.Length then
    swap := True
  else
    swap := False;
end;

var
  fete, baieti: array of string;
  input, nume, prenume, temp: string;
  i, j, fn, bn: Integer;

begin
  fn := 0;
  bn := 0;
  for i := 1 to 10000 do
  begin
    readln(input);
    if Pos(' ', input) > 0 then
    begin
      nume := Copy(input, 1, Pos(' ', input) - 1);
      prenume := Copy(input, Pos(' ', input) + 1, Length(input));
    end;
    if (input.Length > 1) then
    begin
      if (estefata(prenume)) then
      begin
        fn := fn + 1;
        setLength(fete, fn);
        fete[fn - 1] := input;
      end
      else
      begin
        bn := bn + 1;
        setLength(baieti, bn);
        baieti[bn - 1] := input;
      end;
    end
        else 
    begin
      break;
    end;
  end;
  
 for i := 0 to Length(fete) - 2 do
begin
  for j := 0 to Length(fete) - i - 2 do
  begin
    if swap(fete[j], fete[j+1]) then
    begin
      // Swap the elements
      temp := fete[j];
      fete[j] := fete[j + 1];
      fete[j + 1] := temp;
    end;
  end;
end;
  
  Writeln('Fete:');
  for i := 0 to (fn-1) do
  begin
    Writeln(i+1, '. ', fete[i]); 
  end;
  
   for i := 0 to Length(baieti) - 2 do
begin
  for j := 0 to Length(baieti) - i - 2 do
  begin
    if swap(baieti[j], baieti[j+1]) then
    begin
      // Swap the elements
      temp := baieti[j];
      baieti[j] := baieti[j + 1];
      baieti[j + 1] := temp;
    end;
  end;
end;

writeln(' ');
Writeln('Băieți:');
  for i := 0 to (bn-1) do
  begin
    Writeln(i+1, '. ', baieti[i]); 
  end;
end.