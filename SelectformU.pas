unit SelectformU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ComObj, StdCtrls, ExtCtrls, DB, ADODB,
   Grids,ComCtrls, DBGrids;

type
  Tselectfrm = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  selectfrm: Tselectfrm;

implementation

{$R *.dfm}



procedure Tselectfrm.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tselectfrm.GroupBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

end.
