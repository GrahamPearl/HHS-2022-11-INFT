program solution;
{$APPTYPE CONSOLE}
{ Design By: Mr G. Pearl   Email: PearlG@hhs.co.za    2021-12-09
  Purpose:
  Demonstrates the testing of the solve 3x + 1 problem in mathematics
  Produces test files containing the values based on the algorithm

  see: http://oeis.org/wiki/3x%2B1_problem

  Limitations:

  Loop is an INTEGER, maximum representation of values
  Test only positive values for x.

}

uses
  SysUtils;

const
  endOn = ' 4 2 1';

var
  iTest: Integer;
  min, max: Integer;
  tf: Textfile;

{ ==============================================================================
}

function getNext(valueX: Integer): Integer;
begin
  result := 3 * valueX + 1;
end;

function EVEN(valueX: Integer): Boolean;
begin
  result := NOT ODD(valueX);
end;

function endsWITH(startX: Integer; endOn: String): Boolean;
var
  iAm: Integer;
  route: String;
begin
  iAm := startX;
  WriteLN(tf, 'Test Loading: Start with ', startX);

  REPEAT
    iAm := getNext(iAm);
    route := '';
    route := route + ' ' + IntToStr(iAm);

    while EVEN(iAm) do
    begin
      iAm := iAm div 2;
      route := route + ' ' + IntToStr(iAm);
    end;

    WriteLN(tf, route);
    // ReadLN;
  UNTIL route = endOn;

  WriteLN(tf, 'Test Terminating');
  // ReadLN;

  result := TRUE;
end;

{ ==============================================================================
}

function calculatePercentage(value: Integer): Integer;
begin
  result := Round((value / max - min + 1) * 100);
end;

var
  status: String;
  last: Integer;

procedure showProgressBar();
begin
  status := '';
  if last < calculatePercentage(iTest) then
  begin
    status := '#';
    last := calculatePercentage(iTest);
  end;
  Write(status);
end;

{ ==============================================================================
}

begin
  try
    min := 1;
    max := 100;
    last := 0;

    Write('Testing: ');
    for iTest := min to max do
    begin

      showProgressBar();

      AssignFile(tf, '.\Test Data\test' + IntToStr(iTest) + '.txt');
      Rewrite(tf);
      WriteLN(tf, 'Testing: ', iTest, ' = ', endsWITH(iTest, endOn));
      CloseFile(tf);
    end;
    WriteLN;
    WriteLN('Application Run Successfully');
    ReadLN;
  except
    on E: Exception do
      WriteLN(E.ClassName, ': ', E.Message);
  end;

end.
