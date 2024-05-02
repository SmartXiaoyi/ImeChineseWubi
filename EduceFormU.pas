unit EduceFormU;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,StdCtrls, Mask,ComCtrls, Buttons;
type
  Teducefrm = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  educefrm: Teducefrm;
//Const
//  XorKey:array[0..7] of Byte=($B2,$09,$AA,$55,$93,$6D,$84,$47); //�ַ���������

implementation

uses InputU;

{$R *.dfm}


procedure CountChineseChars(SpecStr:string;var aa:string;var bb:string); //�ѱ����뺺�ַֿ����ֱ��������������
var
  shuzu1,shuzu,WSStr:WideString;
  TempStr:string;
  j,i:integer;
begin
  WSStr:=SpecStr;
  j:=1;
  for i:=1 to length(WSStr)do
    begin
      if (ord(WSStr[i])>=33) and (ord(WSStr[i])<=127)then
        begin
           TempStr:=Wsstr[i];
           if (TempStr[1]in['a'..'z','A'..'Z'])then
              begin
                 if j=0 then
                    shuzu:=shuzu+' '+TempStr
                 else
                    shuzu:=shuzu+TemPstr;
                 j:=j+1;
              end
           else
           //ghgfhdf
        end
      else
        begin
          if(ord(WSStr[i])>=127)then
              begin
                 shuzu1:=shuzu1+WSStr[i];
                 j:=0;
              end;

        end;
    end;
   aa:=shuzu;
   bb:=shuzu1;
   shuzu:='';
   shuzu1:='';
end;
procedure Teducefrm.Button1Click(Sender: TObject);
var
  OpenDlg: TOpenDialog;
  strFileName: string;
begin
  OpenDlg := TOpenDialog.Create(nil);
  try
    OpenDlg.Filter := '�ִʿ��ļ�(*.txt)|*.txt|ȫ���ļ�(*.*)|*.*';
    OpenDlg.DefaultExt := '*.txt';
    if OpenDlg.Execute then
    begin
         strFileName := Trim(OpenDlg.FileName);
         if strFileName <> '' then
               begin
                  edit1.Text := strFileName;
               end;
    end;
    finally
        FreeAndNil(OpenDlg);
    end;

end;

procedure Teducefrm.Button3Click(Sender: TObject);
begin
  close;
end;

procedure Teducefrm.Button2Click(Sender: TObject);
var
  my:Tstringlist;
  i,j,suoyin:integer;
  filename,zimf,zimu,zifu:string;
begin
   filename:=edit1.Text;
   my:=Tstringlist.Create();
   my.LoadFromFile(filename);
   zimf:='';
    zimu:='';
    zifu:=''; j:=0;suoyin:=1;
    jm.Clear;
    zw.Clear;
    for i:=1 to 25 do
      begin
        inputu.zikusuoyin[i].en:='';
        inputu.zikusuoyin[i].shou:=0;
        inputu.zikusuoyin[i].wei:=0;
      end;
    for i:=3 to my.Count -1 do
    begin
       zimf:=my[i];
       CountChineseChars(zimf,zimu,zifu);
       if zimu='' then
          begin
            showmessage('"'+filename+'"������Ч���ִʿ�,'+#13+'�������գ��������������뷨��');
            exit;
          end;
       jm.Add(zimu);
       zw.Add(zifu);
       
       if zimu[1] in ['a'..'z','A'..'Z'] then  //����25����ĸ(Z��ĸû��)������ڵ�����,��¼��λ�ð��������ĸ,�����ĸ�Ŀ�ʼλ�� ,
          if (length(zimu)=1) then             //�Լ��������ĸΪ�׵�������ĸ��ϵĽ���λ�� .�������Լ��ٲ��ұ���λ��ʱ��ѭ������
            begin                             //�Լ���cpu������.
                if (j=0) and (suoyin<26) then
                  begin
                    inputu.zikusuoyin[suoyin].en:=zimu[1];
                    inputu.zikusuoyin[suoyin].shou:=i-3;
                    if suoyin >1 then inputu.zikusuoyin[suoyin-1].wei:=i-3-1;
                    suoyin:=suoyin+1;
                    j:=j+1;
                  end ;
            end
          else
            begin
                j:=0;
            end;
         inputu.zikusuoyin[25].wei:=my.Count-1-3;
    end;
    try
      my.Destroy;
    except
     showmessage('����ʿ��ļ�ʧ�ܡ�');
    end;
   close;
end;

procedure Teducefrm.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   if (ssleft in Shift) then
    begin
      ReleaseCapture;
      Perform(WM_syscommand, $F012, 0);
    end;
end;

end.
