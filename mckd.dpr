program mckd;

uses
  Forms,
  Windows,
  InputU in 'InputU.pas' {inputfrm},
  InputwayFormU in 'InputwayFormU.pas' {Inputwayfrm},
  nounglozeU in 'nounglozeU.pas' {nounglozefrm},
  SelectformU in 'SelectformU.pas' {selectfrm},
  VisibleFormU in 'VisibleFormU.pas' {Visiblefrm},
  EduceFormU in 'EduceFormU.pas' {educefrm};

{$R *.RES}

begin
  if  OpenMutex(MUTEX_ALL_ACCESS,True,'Mutex')=0 then
      begin
        CreateMutex(nil,True,'Mutex');
        Application.Initialize;
        Application.CreateForm(Tinputfrm, inputfrm);
        Application.CreateForm(TInputwayfrm, Inputwayfrm);
        Application.CreateForm(Tnounglozefrm, nounglozefrm);
        Application.CreateForm(Tselectfrm, selectfrm);
        Application.CreateForm(TVisiblefrm, Visiblefrm);
        Application.CreateForm(Teducefrm, educefrm);
        Application.Run;
        CloseHandle(OpenMutex(MUTEX_ALL_ACCESS,True,'Mutex'));
      end;
end.
