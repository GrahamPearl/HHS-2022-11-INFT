program solution;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const endOn = ' 4 2 1';

var iTest : Integer;
    min, max : Integer;
    tf : Textfile;

function getNext(valueX : Integer): Integer;
begin result := 3*valueX+1;
end;

function EVEN(valueX : Integer) : Boolean;
begin result := NOT ODD(valueX);
end;

function endsWITH(startX : Integer; endOn : String): Boolean;
var iAm : Integer;
  route : String;
begin
  iAm := startX;
  WriteLN(tf,'Test Loading: Start with ',startX);

  REPEAT
   iAm := getNext(iAm);
   route := '';
   route := route +' '+ IntToStr(iAM);

  while EVEN(iAM) do begin
    iAM := iAM div 2;
    route := route +' '+ IntToStr(iAM);
  end;


  WriteLN(tf,route);
//   ReadLN;
  UNTIL route = endOn;

  WriteLN(tf,'Test Terminating');
//   ReadLN;

  result := TRUE;
end;

function progress(value : Integer) : Integer;
begin result := Round((value/max-min+1)*100);
end;

var status : String;
    last : Integer;

procedure showProgressBar();
begin
  status := '';
  if last < progress(iTest) then begin status := '#'; last := progress(iTest); end;
  Write(status);
end;


begin
  try
  min := 1;
  max := 10000;
  last := 0;

  Write('Testing: ');
  for iTest := min to max do
  begin

      showProgressBar();

      AssignFile(tf,'test'+IntToStr(iTest)+'.txt');
      Rewrite(tf);
      WriteLN(tf,'Testing: ',iTest,' = ', endsWITH(iTest,endOn));
      CloseFile(tf);
  end;
  WriteLN;
  WriteLN('Application Run Successfully');
  ReadLN;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
