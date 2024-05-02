unit VisibleFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,  StdCtrls,  DB, ADODB;

type
  TVisiblefrm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private

  public
    
  end;

var
  Visiblefrm: TVisiblefrm;

implementation
uses InputU;
{$R *.dfm}



procedure TVisiblefrm.Button1Click(Sender: TObject);
 var
   i:integer;
begin
   for i:=1 to 25 do
    memo1.Lines.Insert(i,zikusuoyin[i].en+' --> '+inttostr(zikusuoyin[i].shou)+' µ½ '+inttostr(zikusuoyin[i].wei));
end;

procedure TVisiblefrm.Button2Click(Sender: TObject);
begin
   close;
end;

procedure TVisiblefrm.Button3Click(Sender: TObject);
var
  i,j,k:Integer;
begin

    For  i:=1 to 100 do
        begin
           Randomize;
           k:=random(jm.Count);
           memo1.Lines.Insert(i,jm[k]+' --> '+jm[k]+' | '+zw[k]);
        End;
end;

procedure TVisiblefrm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

end.
