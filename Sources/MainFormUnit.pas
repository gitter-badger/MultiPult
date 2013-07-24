unit MainFormUnit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ELSE}
  {$IFDEF VER140} // Delphi 6
    {$DEFINE Delphi6}
  {$ELSE}
    {$DEFINE DelphiXE+}
  {$ENDIF}
{$ENDIF}

interface
{$WARN UNIT_PLATFORM OFF}
uses
{$IFNDEF FPC}
  jpeg,
{$ELSE}
  lclproc, fileutil, JwaWinBase, lMessages, FPReadJPEG,
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, ExtCtrls, ImgList, ExtDlgs, StdCtrls, Contnrs,
  Gauges, Buttons, Math, ComCtrls, FileCtrl, mmSystem,
  WaveUtils, WaveStorage, WaveOut, WavePlayers, WaveIO, WaveIn, WaveRecorders, WaveTimer,
  ToolWin, ExtActns;

const
  ControlActionStackDeep = 10;
type
  TControlAction = (caNone, caStepBackward, caStepForward, caPlayBackward, caPlayForward);
  TFrameTipMode = (ftmTimeLine, ftmRecord);
const
  FrameTipW = 120;
  FrameTipH = 90;
  FrameTipD = 5;
  FrameTipT = 2;

type
  TFrame = class
  private
    FPath, FFileName: string;
  public
    Preview: TBitmap;
    Teleport: Integer;
    Loaded: Boolean;
    function ImageFromDisc: TGraphic;
    function GenerateStubFrame(ErrorMessage: string): TGraphic;
    property FileName: string read FFileName;
    property Path: string read FPath;
    constructor Create(APath, AFileName: string);
    destructor Destroy; override;
  end;

  TMainForm = class(TForm)
    pnlDisplay: TPanel;
    pbDisplay: TPaintBox;
    ActionList: TActionList;
    MainMenu: TMainMenu;
    actOpen: TAction;
    actNew: TAction;
    actSave: TAction;
    actSelectPhotoFolder: TAction;
    mmiSelectPhotoFolder: TMenuItem;
    mmiFiles: TMenuItem;
    mmiNew: TMenuItem;
    mmiOpen: TMenuItem;
    mmiSave: TMenuItem;
    mmiNavigation: TMenuItem;
    actStepPrev: TAction;
    actStepNext: TAction;
    actToggleBookmark0: TAction;
    actNewBookmark: TAction;
    actRecord: TAction;
    actExport: TAction;
    pnlTimeLine: TPanel;
    pbTimeLine: TPaintBox;
    OpenPictureDialog: TOpenPictureDialog;
    mmiNext: TMenuItem;
    mmiPrev: TMenuItem;
    mmiSeparatorBookmarkManagement: TMenuItem;
    mmiNewBookmark: TMenuItem;
    mmiToggleBookmark0: TMenuItem;
    mmiExport: TMenuItem;
    mmiRecord: TMenuItem;
    actGotoBookmark0: TAction;
    mmiGotoBookmark0: TMenuItem;
    mmiSeparatorBookmarks: TMenuItem;
    Timer: TTimer;
    actPlayForward: TAction;
    mmiPlayingForward: TMenuItem;
    actExit: TAction;
    mmiExitSeparator: TMenuItem;
    mmiExit: TMenuItem;
    WaveStorage: TWaveStorage;
    AudioRecorder: TAudioRecorder;
    pbRecord: TPaintBox;
    mmiPlayBackward: TMenuItem;
    actPlayBackward: TAction;
    StockAudioPlayer: TStockAudioPlayer;
    pnlToolls: TPanel;
    LevelGauge: TGauge;
    actPlay: TAction;
    mmiSeparatorSteps: TMenuItem;
    mmiPlay: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    pbIndicator: TPaintBox;
    actExportToAVI: TAction;
    mmiExportToAVI: TMenuItem;
    actForwardWhilePressed: TAction;
    mmiForwardWhilePressed: TMenuItem;
    actBackwardWhilePressed: TAction;
    mmiBackwardWhilePressed: TMenuItem;
    SaveToAVIDialog: TSaveDialog;
    RecordSplitter: TSplitter;
    mmiN1: TMenuItem;
    actToggleTeleport0: TAction;
    mmiToggleTeleport0: TMenuItem;
    mmiMode: TMenuItem;
    mmiDoubleFramerate: TMenuItem;
    LiveAudioRecorder: TLiveAudioRecorder;
    mmiPreviewMode: TMenuItem;
    ilActions: TImageList;
    tlbNavigation: TToolBar;
    btnPlayBackward: TToolButton;
    btnPlayForward: TToolButton;
    btnPlay: TToolButton;
    btnRecord: TToolButton;
    btnPrev: TToolButton;
    btnNext: TToolButton;
    btnBackwardWhilePressed: TToolButton;
    btnForwardWhilePressed : TToolButton;
    actPreviewMode: TAction;
    actDoubleFramerate: TAction;
    actAbout: TAction;
    actFullScreenMode: TAction;
    mmiFullScreenMode: TMenuItem;
    ilActionsDisabled: TImageList;
    actStretchImages: TAction;
    mmiStretchImages: TMenuItem;
    pbFrameTip: TPaintBox;
    mmiShowIssuesPage: TMenuItem;
    actShowIssuesPage: TBrowseURL;
    actShowControllerForm: TAction;
    mmiShowControllerForm: TMenuItem;
    actScreenWindow: TAction;
    mmiScreenWindow: TMenuItem;
    actShowMultiStudiaPage: TBrowseURL;
    mmiShowMultiStudiaPage: TMenuItem;
    imgBackgroundSource: TImage;
    StatusBar: TStatusBar;
    procedure actSelectPhotoFolderClick(Sender: TObject);
    procedure actStepNextExecute(Sender: TObject);
    procedure actStepPrevExecute(Sender: TObject);
    procedure pbDisplayPaint(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure pbTimeLinePaint(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure actPlayForwardExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actRecordExecute(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure pbRecordPaint(Sender: TObject);
    procedure actPlayBackwardExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actToggleBookmarkExecute(Sender: TObject);
    procedure actGotoBookmark0Execute(Sender: TObject);
    procedure actPlayUpdate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure AudioRecorderFilter(Sender: TObject; const Buffer: Pointer;
      BufferSize: Cardinal);
    procedure actOpenExecute(Sender: TObject);
    procedure actNavigate_Update(Sender: TObject);
    procedure actUpdate_HaveRecorded(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure pbIndicatorPaint(Sender: TObject);
    procedure actForwardWhilePressedExecute(Sender: TObject);
    procedure mmiBackwardWhilePressedClick(Sender: TObject);
    procedure actExportToAVIExecute(Sender: TObject);
    procedure actToggleTeleport0Execute(Sender: TObject);
    procedure pbIndicatorClick(Sender: TObject);
    procedure actDoubleFramerateExecute(Sender: TObject);
    procedure AudioRecorderActivate(Sender: TObject);
    procedure AudioRecorderDeactivate(Sender: TObject);
    procedure LiveAudioRecorderData(Sender: TObject; const Buffer: Pointer;
      BufferSize: Cardinal; var FreeIt: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StockAudioPlayerActivate(Sender: TObject);
    procedure StockAudioPlayerDeactivate(Sender: TObject);
    procedure pbRecordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbRecordMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actPreviewModeExecute(Sender: TObject);
    procedure actFullScreenModeExecute(Sender: TObject);
    procedure btnBackwardWhilePressedMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBackwardWhilePressedMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBackwardWhilePressedMouseLeave(Sender: TObject);
    procedure actBackwardWhilePressedExecute(Sender: TObject);
    procedure btnForwardWhilePressedMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnForwardWhilePressedMouseLeave(Sender: TObject);
    procedure btnForwardWhilePressedMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnNavigationMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbTimeLineMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbTimeLineMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbFrameTipPaint(Sender: TObject);
    procedure pbTimeLineMouseLeave(Sender: TObject);
    procedure pbRecordMouseLeave(Sender: TObject);
    procedure actShowControllerFormExecute(Sender: TObject);
    procedure actShowControllerFormUpdate(Sender: TObject);
    procedure tlbNavigationMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actStretchImagesExecute(Sender: TObject);
    procedure actScreenWindowExecute(Sender: TObject);
    procedure pbDisplayDblClick(Sender: TObject);
    procedure mmiNewBookmarkClick(Sender: TObject);
  private
    NextControlActionStack: array [1..ControlActionStackDeep] of TControlAction;
    NextControlActionStackPosition: Integer;
    function NextControlAction: TControlAction;
    procedure PopControlAction;
    procedure PushControlAction(Value: TControlAction);
    procedure ReplaceControlActions(Value: TControlAction);
  private
    PhotoFolder: string;
    //FileNames: TStringList;
//    BufferIndexes: TList;
    FFrames: TObjectList;

    HaveBuffers: Boolean;
    KeyPressBlocked: Boolean;
    Interval, CurrentSpeedInterval: Integer;
    Recording, Playing, Exporting: Boolean;
    LoopMode: Boolean;
    RecordedFrames: TList;
    FrameTipMode: TFrameTipMode;
    FrameTipArrow: Integer;
    Bookmarks: array [0..9] of Integer;
    Saved: Boolean;
    RecordedAudioCopy: TMemoryStream;
    pbRecordOffset: Integer;
    OutOfMemoryRaised: Boolean;
    PreviousBounds: TRect;
    FFrameTipIndex: Integer;
    FCurrentRecordPosition: Integer;
    FCurrentFrameIndex: Integer;
    procedure SetCurrentRecordPosition(const Value: Integer);
    procedure SetCurrentFrameIndex(const Value: Integer);
    procedure UpdatePlayActions;
    property CurrentRecordPosition: Integer read FCurrentRecordPosition write SetCurrentRecordPosition;
    procedure SetFrameTipIndex(const Value: Integer);
    function TeleportEnabled: Boolean;
    procedure OpenMovie(AFileName: string);
    property FrameTipIndex: Integer read FFrameTipIndex write SetFrameTipIndex;
    function GetFrame(Index: Integer): TFrame;
    function GetFramesCount: Integer;
    procedure UnloadFrames;
    function FrameIndexToTimeLineX(FrameIndex: Integer): Integer;
    function TimeLineXToFrameIndex(X: Integer): Integer;
//    Drawing: Boolean;
    procedure LoadPhotoFolder(ARelativePath: string);
    procedure ApplicationIdle(Sender: TObject; var Done: Boolean);
    procedure ClearRecorded;
    procedure RecalculatePreview;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsShortCut(var Message: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean; override;
    procedure SetCaption(const Value: TCaption);
    procedure SetStatus(const Value: string);
    property CurrentFrameIndex: Integer read FCurrentFrameIndex write SetCurrentFrameIndex;
    function IncrementCurrentFrameIndex(AOffset: Integer): Integer;
    property FramesCount: Integer read GetFramesCount;
    property Frames[Index: Integer]: TFrame read GetFrame;
    // Used in ScreenForm
    procedure LoadPhoto(Index: Integer);
  end;

var
  MainForm: TMainForm;

var
  FrameRate: byte = 25;
function StretchSize(AWidth, AHeight, ABoundsWidth, ABoundsHeight: Integer): TRect;

implementation
uses AVICompression, ControllerFormUnit, ScreenFormUnit;
{$R *.dfm}

function StretchSize(AWidth, AHeight, ABoundsWidth, ABoundsHeight: Integer): TRect;
begin
  Result.Left   := 0;
  Result.Top    := 0;
  Result.Right  := MulDiv(AWidth, ABoundsHeight, AHeight);
  Result.Bottom := MulDiv(AHeight, ABoundsWidth, AWidth);
  if Result.Right > ABoundsWidth then
    begin
      Result.Right := ABoundsWidth;
      Result.Top := (ABoundsHeight - Result.Bottom) div 2;
      Result.Bottom := Result.Bottom + Result.Top;
    end;
  if Result.Bottom > ABoundsHeight then
    begin
      Result.Bottom := ABoundsHeight;
      Result.Left := (ABoundsWidth - Result.Right) div 2;
      Result.Right := Result.Right + Result.Left;
    end;
end;

procedure TMainForm.actSelectPhotoFolderClick(Sender: TObject);
resourcestring
  rs_SelectPhotoFolderCaption = '� ����� ����� �������� ������ �����?';
begin
  actNew.Execute;
  PhotoFolder := ExpandFileName('..\testdata\');
  if SelectDirectory(
    rs_SelectPhotoFolderCaption, '', PhotoFolder
    {$IFDEF DelphiXE}
    , [sdNewFolder, sdShowFiles, sdShowEdit, (*sdShowShares, *) sdValidateDir, sdNewUI]
    {$ENDIF}
  ) then
    LoadPhotoFolder('\');
  CurrentFrameIndex := 0;
  Saved := False;
end;

procedure TMainForm.actShowControllerFormExecute(Sender: TObject);
begin
  ControllerForm.Visible := not ControllerForm.Visible;
end;

procedure TMainForm.actShowControllerFormUpdate(Sender: TObject);
begin
  actShowControllerForm.Checked := ControllerForm.Visible;
end;

constructor TMainForm.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  CurrentSpeedInterval := 3;
  Saved := True;
//  BufferIndexes := TList.Create;
  FFrames := TObjectList.Create(True);
  RecordedFrames := TList.Create;
  RecordedAudioCopy := TMemoryStream.Create;
  Application.OnIdle := ApplicationIdle;
  for i := 0 to 9 do
    Bookmarks[i] := -1;
end;

function TMainForm.NextControlAction: TControlAction;
begin
  if NextControlActionStackPosition >= 1 then
    Result := NextControlActionStack[NextControlActionStackPosition]
  else
    Result := caNone;
end;

destructor TMainForm.Destroy;
begin
  Timer.Enabled := False;
  FreeAndNil(RecordedAudioCopy);
//  FreeAndNil(BufferIndexes);
  FreeAndNil(FFrames);
  inherited Destroy;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  rs_SaveBeforeExit =
    '�� ���������� ���������, � �� ����� ��� ���������� ���� ������� ��� �� ��������.'#13#10+
    '���� ��� �� ��������� ������, �� �� �������.'#13#10+
    '������� ��� ���������, ������ ��� ������� ���������?';
begin
  actSave.Update;
  if actSave.Enabled then
    case MessageBox(
      0,
      PChar(rs_SaveBeforeExit),
      PChar(Application.Title),
      MB_ICONQUESTION or MB_YESNOCANCEL or MB_APPLMODAL or MB_DEFBUTTON1
    ) of
      IDYES: begin actSave.Execute; CanClose := Saved; end;
      IDNO: CanClose := True;
      IDCANCEL: CanClose := False;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;

  procedure AppendBookmarkMenu(Index: Integer);
  var
    MenuItem: TMenuItem;
  begin
    MenuItem := TMenuItem.Create(Self);
    MenuItem.Action := actToggleBookmark0;
    MenuItem.Tag := Index;
    MenuItem.Caption := StringReplace(MenuItem.Caption, '0', IntToStr(Index), []);
    MenuItem.Hint := MenuItem.Caption;
    MenuItem.ShortCut := TextToShortCut('Ctrl+' + IntToStr(Index));
    mmiToggleBookmark0.Parent.Insert(mmiToggleBookmark0.Parent.IndexOf(mmiToggleBookmark0), MenuItem);
    MenuItem.Action := nil;

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Action := actGotoBookmark0;
    MenuItem.Tag := Index;
    MenuItem.Caption := StringReplace(MenuItem.Caption, '0', IntToStr(Index), []);
    MenuItem.Hint := MenuItem.Caption;
    MenuItem.ShortCut := TextToShortCut(IntToStr(Index));
    mmiGotoBookmark0.Parent.Insert(mmiGotoBookmark0.Parent.IndexOf(mmiGotoBookmark0), MenuItem);
    MenuItem.Action := nil;

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Action := actToggleTeleport0;
    MenuItem.Tag := Index;
    MenuItem.Caption := StringReplace(MenuItem.Caption, '0', IntToStr(Index), []);
    MenuItem.Hint := MenuItem.Caption;
    MenuItem.ShortCut := TextToShortCut('Shift+' + IntToStr(Index));
    mmiToggleTeleport0.Parent.Insert(mmiToggleTeleport0.Parent.IndexOf(mmiToggleTeleport0), MenuItem);
    MenuItem.Action := nil;
  end;

begin
  for i := 1 to 9 do
    AppendBookmarkMenu(i);

  mmiToggleBookmark0.Action.Free;
  mmiGotoBookmark0.Action.Free;
  LiveAudioRecorder.Active := True;

  pnlDisplay.DoubleBuffered := True;
  pnlTimeLine.DoubleBuffered := True;
  pnlToolls.DoubleBuffered := True;

  FrameTipIndex := -1;

  {$IFDEF DelphiXE+}
  pnlDisplay.ParentBackground := False;
  pnlTimeLine.ParentBackground := False;
  pnlToolls.ParentBackground := False;
  {$ENDIF}

  with btnBackwardWhilePressed do ControlStyle := ControlStyle - [csCaptureMouse];
  with btnForwardWhilePressed  do ControlStyle := ControlStyle - [csCaptureMouse];
  with btnPrev         do ControlStyle := ControlStyle - [csClickEvents];
  with btnNext         do ControlStyle := ControlStyle - [csClickEvents];
  with btnPlayBackward do ControlStyle := ControlStyle - [csClickEvents];
  with btnPlayForward  do ControlStyle := ControlStyle - [csClickEvents];
//  DoubleBuffered := True;
  if ParamCount >= 1 then
    OpenMovie(ParamStr(1));
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  LiveAudioRecorder.Active := False;
  LiveAudioRecorder.WaitForStop;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
    case Key of
      vk_Left:
        if NextControlAction <> caPlayBackward then
          ReplaceControlActions(caPlayBackward)
        else
          ReplaceControlActions(caNone);
      vk_Right:
        if NextControlAction <> caPlayForward then
          ReplaceControlActions(caPlayForward)
        else
          ReplaceControlActions(caNone);
      vk_Up:   begin Inc(CurrentSpeedInterval); end;
      vk_Down: begin Dec(CurrentSpeedInterval); if CurrentSpeedInterval < 1  then CurrentSpeedInterval := 1; end;
    end
  else
    if not KeyPressBlocked then
      case Key of
        vk_Left:   begin PushControlAction(caStepBackward); KeyPressBlocked := True; end;
        vk_Right:  begin PushControlAction(caStepForward); KeyPressBlocked := True; end;
        VK_ESCAPE: if actFullScreenMode.Checked then actFullScreenMode.Execute; // TODO: ��� ��� ��� ����� ��������� ��������?
        vk_Shift:  pbTimeLine.Invalidate; // ��������� �����������
      end;

  UpdatePlayActions;
//  pbIndicator.Invalidate;
//  pbIndicator.Refresh;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyPressBlocked := False; // TODO: �������������� �� ����� �������, � ��, ��� �����������. ���� �� ��������������, ��������, ��� ������ ��� ���������� ����-�� �������.
  case Key of
    vk_Shift: pbTimeLine.Invalidate; // ��������� ����������
  end;
//  pbIndicator.Refresh;
end;

function TMainForm.GetFrame(Index: Integer): TFrame;
begin
  Result := FFrames[Index] as TFrame;
end;

function TMainForm.GetFramesCount: Integer;
begin
  Result := FFrames.Count;
end;

procedure TMainForm.UnloadFrames;
begin
  FFrames.Clear;
  OutOfMemoryRaised := False;
end;

function CompareFramesFileName(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText(
    TFrame(Item1).Path + TFrame(Item1).FileName,
    TFrame(Item2).Path + TFrame(Item2).FileName
  )
end;

procedure TMainForm.LoadPhotoFolder(ARelativePath: string);

resourcestring
  rs_ScaningStatus = '������ �����: ';

  procedure InternalLoadDirectory(ARelativePath: string);
  var
    Rec: TSearchRec;
    ext: string;
  begin
    SetStatus(rs_ScaningStatus + PhotoFolder + ARelativePath);
    if {$IFDEF FPC}FindFirstUTF8{$ELSE}FindFirst{$ENDIF}(PhotoFolder + ARelativePath + '*.*', faAnyFile, Rec) = 0 then
      begin
        repeat
          ext := AnsiLowerCase(ExtractFileExt(Rec.Name));
          if (ext = '.jpg') or (ext = '.jpeg') then
            begin
              FFrames.Add(TFrame.Create(ARelativePath, Rec.Name));
            end;
          if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and (Rec.Name <> '..') then
            InternalLoadDirectory(ARelativePath + Rec.Name + '\');
        until {$IFDEF FPC}FindNextUTF8{$ELSE}FindNext{$ENDIF}(Rec) <> 0;
        {$IFDEF FPC}FindCloseUTF8{$ELSE}FindClose{$ENDIF}(Rec);
      end;
  end;
//  i: Integer;
begin
  SetCaption(PhotoFolder);

  UnloadFrames;
//  BufferIndexes.Clear;
  HaveBuffers := True;

  InternalLoadDirectory(ARelativePath);

  FFrames.Sort(CompareFramesFileName);
//  ListBox.Items.Assign(FileNames);
  UpdateActions;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
resourcestring
  rs_AboutText =
    '������ 0.9.15'#13#10 +
    '�����: ���� ������� (http://innenashev.narod.ru)'#13#10 +
    '�� ������ ������������ (http://multistudia.ru)'#13#10 +
    '� ���� ������� ����������� ��������'#13#10 +
    ''#13#10 +
    '�������� ��� ��������� �������� ��� ��������� � ���������'#13#10 +
    '�� ������ https://github.com/Nashev/MultiPult'#13#10 +
    ''#13#10 +
    '(� �� ������, ��� Ctrl+C � �������� ������� ��������?)';
begin
  ShowMessage(
    Application.Title + #13#10 +
    rs_AboutText
  );
end;


procedure TMainForm.mmiBackwardWhilePressedClick(Sender: TObject);
begin
 //
end;

procedure TMainForm.mmiNewBookmarkClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to 10 do // ������� ��������� ����� ��������, ���� ��� ��� ��� ����. ����� Enter ���� ������������ ��������
    // ���������� 1-10 � ���������� i mod 10, ����� ������ 0 ��� ����� 9, ��� �� ����������
    if Bookmarks[i mod 10] = CurrentFrameIndex then
      begin
        Bookmarks[i mod 10] := -1;
        pbTimeLine.Invalidate;
        Saved := False;
        Exit;
      end;

  for i := 1 to 10 do // ���� �� ���� �������� - �� ������ ������ ���������
    if Bookmarks[i mod 10] = -1 then
      begin
        Bookmarks[i mod 10] := CurrentFrameIndex;
        pbTimeLine.Invalidate;
        Saved := False;
        Exit;
      end;

  Beep; // ���� ��������� �������� �� ������� - �����.
end;

procedure TMainForm.actBackwardWhilePressedExecute(Sender: TObject);
begin
 //
end;

procedure TMainForm.actDoubleFramerateExecute(Sender: TObject);
begin
  if FrameRate = 25 then
    FrameRate := 50
  else
    FrameRate := 25;
  actDoubleFramerate.Checked := (FrameRate = 50);

  Timer.Interval := 1000 div FrameRate;
  pnlToolls.Invalidate;
//  Invalidate;
end;

procedure TMainForm.actPreviewModeExecute(Sender: TObject);
begin
  RecalculatePreview;
end;

type
  LPVOID = Pointer;

function CopyProgressHandler(
  TotalFileSize, TotalBytesTransferred, StreamSize, StreamBytesTransferred: LARGE_INTEGER;
  dwStreamNumber, dwCallbackReason: Integer;
  hSourceFile, hDestinationFile: THANDLE;
  lpData: LPVOID
): Integer; stdcall;
begin
//  TMainForm(lpData).SetStatus('����������� �����: ' + FloatToStrF(TotalBytesTransferred / TotalFileSizeTotalFileSize) * 100, ffFixed, 0, 2) + '%';
  Result := PROGRESS_CONTINUE;
end;

procedure SetCurrentCreateDatetime(const FileName: string);
var
  f: THandle;
  LocalFileTime, FileTime: TFileTime;
//  SystemTime: TSystemTime;
begin
  f := FileOpen(FileName, fmOpenWrite);
  if f <> THandle(-1) then
  begin
    GetSystemTimeAsFileTime(LocalFileTime);
    LocalFileTimeToFileTime(LocalFileTime, FileTime);
    SetFileTime(f, @FileTime, nil, nil);
    FileClose(f);
  end;
end;


procedure TMainForm.actExportExecute(Sender: TObject);
var
  Dir: string;
  i: Integer;
  Cancel: BOOL;
  NewFileName: string;
resourcestring
  rs_ExportSelectFolderCaption = '�������� ����� ��� ��������';
  rs_FramesExportingCaption = '�������. ����������� ����� %0:d �� %1:d';
begin
  Dir := GetCurrentDir;
  if SelectDirectory(
    rs_ExportSelectFolderCaption, '', Dir
    {$IFDEF DelphiXE}
    , [sdNewFolder, sdShowFiles, sdShowEdit, (*sdShowShares, *) sdValidateDir, sdNewUI]
    {$ENDIF}
  )
  then
    begin
//      SetCurrentDir(Dir);
      Exporting := True;
      try
        dir := IncludeTrailingPathDelimiter(dir);
        WaveStorage.Wave.SaveToFile(Dir + 'AudioTrack.wav');
        for i := 0 to RecordedFrames.Count - 1 do
          begin
            CurrentRecordPosition := i;
            CurrentFrameIndex := Integer(RecordedFrames[CurrentRecordPosition]);
            pbRecord.Invalidate;
            SetStatus(Format(rs_FramesExportingCaption, [i + 1, RecordedFrames.Count]));
            Application.ProcessMessages;
            Cancel := False;
            NewFileName := Dir + Format('Frame%.5d.jpg', [i]);
            if not CopyFileEx(
              PChar(PhotoFolder + Frames[Integer(RecordedFrames[i])].Path + Frames[Integer(RecordedFrames[i])].FileName),
              PChar(NewFileName),
              @CopyProgressHandler,
              @Self,
              {$IFNDEF FPC}@{$ENDIF}Cancel,
              {$IFDEF DelphiXE}COPY_FILE_ALLOW_DECRYPTED_DESTINATION or {$ENDIF}
              COPY_FILE_RESTARTABLE
            ) then
              RaiseLastOSError;
            SetCurrentCreateDatetime(NewFileName);
          end;
      finally
        Exporting := False;
      end;
    end;
end;

// procedure CheckOSError(RetVal: Integer);
// begin
//   Win32Check(LongBool(RetVal));
// end;

procedure TMainForm.actExportToAVIExecute(Sender: TObject);
var
  Compressor: TAVICompressor;
  Options: TAVIFileOptions;
  i: Integer;
  Bmp: Graphics.TBitmap;
  Image: TGraphic;
  Dir: string;
  OldCurrentFrameIndex: Integer;
//  Cancel: BOOL;
resourcestring
  rs_AVIExportingCaption = '������� � AVI. ������ ����� %0:d �� %1:d';
begin
  Dir := GetCurrentDir;
  OldCurrentFrameIndex := CurrentFrameIndex;
  if SaveToAVIDialog.Execute then
    begin
//      SetCurrentDir(Dir);
      Dir := ExtractFilePath(SaveToAVIDialog.FileName);
      Exporting := True;
      try
        WaveStorage.Wave.SaveToFile(Dir + '~Audio.wav');
        Compressor := TAVICompressor.Create;
        Options.Init;
        Options.FrameRate := FrameRate;
        Options.Width := 640;
        Options.Height := 480;
        CheckAVIError(Compressor.Open(Dir + '~Video.avi', Options));
        Bmp := TBitmap.Create;
        for i := 0 to RecordedFrames.Count - 1 do
          begin
            CurrentRecordPosition := i;
            CurrentFrameIndex := Integer(RecordedFrames[CurrentRecordPosition]);
            pbRecord.Invalidate;
            SetStatus(Format(rs_AVIExportingCaption, [i + 1, RecordedFrames.Count]));
            Application.ProcessMessages;
            Image := Frames[CurrentFrameIndex].Preview;
            Bmp.Assign(Image);
            Bmp.PixelFormat := pf24bit;
            CheckAVIError(Compressor.WriteFrame(Bmp));
          end;
        Bmp.Free;
        Compressor.Close;

        Compressor.MergeFilesAndSaveAs(Dir + '~Video.avi', Dir + '~Audio.wav', SaveToAVIDialog.FileName);

        Compressor.Destroy;
        {$IFDEF FPC}DeleteFileUTF8{$ELSE}DeleteFile{$ENDIF}(Dir + '~Audio.wav');
        {$IFDEF FPC}DeleteFileUTF8{$ELSE}DeleteFile{$ENDIF}(Dir + '~Video.avi');
      finally
        Exporting := False;
        CurrentFrameIndex := OldCurrentFrameIndex;
      end;
    end;
end;

procedure TMainForm.actForwardWhilePressedExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.actFullScreenModeExecute(Sender: TObject);
begin
  if ScreenForm.Visible then
    ScreenForm.UpdateFullScreen
  else
    if actFullScreenMode.Checked then
      begin
        BorderStyle := bsNone;
        PreviousBounds := BoundsRect;
        BoundsRect := Self.Monitor.BoundsRect;
        // FormStyle := fsStayOnTop;
        pnlDisplay.Align := alNone;
        pnlDisplay.BringToFront;
        Menu := nil;
        with Self.ClientRect do
          pnlDisplay.SetBounds(Left, Top, Right, Bottom);
        pbRecord.Hide;
        StatusBar.Hide;
        RecordSplitter.Hide;
        FrameTipIndex := -1;  // hide
      end
    else
      begin
        pnlDisplay.Align := alClient;
        BorderStyle := bsSizeable;
        BoundsRect := PreviousBounds;
        FormStyle := fsNormal;
        pbRecord.Show;
        StatusBar.Show;
        RecordSplitter.Left := pbRecord.Left - 5;
        RecordSplitter.Show;
        Menu := MainMenu;
      end;
end;

procedure TMainForm.actNewExecute(Sender: TObject);
resourcestring
  rs_SaveBeforeNewRequest = '������ ��������� ������� ����� ����� ��������� ������?';
begin
  if (RecordedFrames.Count > 0) and not Saved then
    case MessageBox(
      0,
      PChar(rs_SaveBeforeNewRequest),
      PChar(Application.Title),
      MB_ICONQUESTION or MB_YESNOCANCEL or MB_APPLMODAL or MB_DEFBUTTON1)
    of
      IDCANCEL: Exit;
      IDYES:
        begin
          actSave.Execute;
          if not Saved then
            Exit;
        end;
      IDNO: ;
    end;

  ClearRecorded;
  pbRecord.Invalidate;
  UpdateActions;
end;

const
  FilesSectionStart     = '-------------------- Files: ----------------------';
  BookmarkSectionStart  = '------------------- Bookmarks: --------------------';
  FrameSectionStart     = '-------------------- Frames: ----------------------';
  TeleportsSectionStart = '------------------- Teleports: --------------------';

procedure TMainForm.OpenMovie(AFileName: string);
var
  i: Integer;
  WaveFileName: string;
  s: string;
  LastDelimiterPos: Integer;

  procedure ReadTeleport(s: string);
  var
    FrameIndex: Integer;
    SeparatorPos: Integer;
    TargetIndex: Integer;
  begin
    SeparatorPos := pos('=', s);
    FrameIndex := StrToInt(Trim(Copy(s, 1, SeparatorPos-1)));
    TargetIndex := StrToInt(Trim(Copy(s, SeparatorPos+1, Length(s))));
    Frames[FrameIndex].Teleport := TargetIndex;
  end;

begin
  ClearRecorded;
  PhotoFolder := ExtractFilePath(AFileName);
  UnloadFrames;

  with TStringList.Create do
    try
      LoadFromFile(AFileName);
      i := 0;
      s := Strings[i];
      if WaveStorage.Wave.Empty and (Copy(s, 1, Length('Wave = ')) = 'Wave = ') then
        begin
          WaveFileName := Copy(s, Length('Wave = ') + 1, MaxInt);
          if {$IFDEF FPC}FileExistsUTF8{$ELSE}FileExists{$ENDIF}(PhotoFolder + WaveFileName) then
            begin
              WaveStorage.Wave.LoadFromFile(PhotoFolder + WaveFileName);
              WaveStorage.Wave.Stream.Position := WaveStorage.Wave.DataOffset;
              RecordedAudioCopy.CopyFrom(WaveStorage.Wave.Stream, WaveStorage.Wave.DataSize);
              WaveStorage.Wave.Position := 0;
            end
          else
            WaveStorage.Wave.Clear;
        end;
      inc(i);
      s := Strings[i];
      if s = FilesSectionStart then
        while i < (Count - 1) do
          begin
            inc(i);
            s := Strings[i];
            if s = BookmarkSectionStart then
              Break;
            LastDelimiterPos := LastDelimiter(PathDelim + DriveDelim, s);
            FFrames.Add(TFrame.Create(Copy(s, 1, LastDelimiterPos), Copy(s, LastDelimiterPos + 1, MaxInt)));
          end;
      if s = BookmarkSectionStart then
        while i < (Count - 1) do
          begin
            inc(i);
            s := Strings[i];
            if s = FrameSectionStart then // for compatibility with prev.saves without Teleports
              Break;
            if s = TeleportsSectionStart then
              Break;
            Bookmarks[StrToInt(s[Length('Bookmark') + 1])] := StrToInt(Copy(s, Length('Bookmark0 = ') + 1, MaxInt));
          end;
      if s = TeleportsSectionStart then
        while i < (Count - 1) do
          begin
            inc(i);
            s := Strings[i];
            if s = FrameSectionStart then
              Break;
            ReadTeleport(s);
          end;
      if s = FrameSectionStart then
        while i < (Count - 1) do
          begin
            inc(i);
            s := Strings[i];
            RecordedFrames.Add(Pointer(StrToInt(s)));
          end;
    finally
      Free;
    end;
  if FramesCount > 0 then
    CurrentFrameIndex := 0;
  Saved := True;
  pbRecord.Invalidate;
  UpdateActions;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
resourcestring
  rs_SaveBeforeOpenRequest = '������ ��������� ������� ����� ����� ��������� �������?';
begin
  if not OpenDialog.Execute then
    Abort;

  if (RecordedFrames.Count > 0) and not Saved then
    case MessageBox(
      0,
      PChar(rs_SaveBeforeOpenRequest),
      PChar(Application.Title),
      MB_ICONQUESTION or MB_YESNOCANCEL or MB_APPLMODAL or MB_DEFBUTTON1)
    of
      IDCANCEL: Exit;
      IDYES:
        begin
          actSave.Execute;
          if not Saved then
            Exit;
        end;
      IDNO: ;
    end;

  OpenMovie(OpenDialog.FileName);
end;

procedure TMainForm.actSaveExecute(Sender: TObject);
var
  i: Integer;
  NewPath: string;
begin
  SaveDialog.InitialDir := PhotoFolder;
  if not SaveDialog.Execute then
    Abort;

  NewPath := ExtractFilePath(SaveDialog.FileName);
  if NewPath <> PhotoFolder then
    // TODO: �� ����������, � ���������� ������������� ���� �� �����������
    ShowMessage(
    '��������!'#13#10+
    '���� � ������ ������ � ����� ������� ����� �� ����� ��������� ������������ '#13#10+
    '  "' + PhotoFolder + '", '#13#10+
    '� �� ������������ '#13#10+
    '  "' + NewPath + '".'#13#10+
    '��� �������� ������� ������� ��������������� ��������� ��������� � ������������� ������������ ����� �������.');
  WaveStorage.Wave.SaveToFile(SaveDialog.FileName + '.wav');
  with TStringList.Create do
    try
      Add('Wave = ' + ExtractFileName(SaveDialog.FileName) + '.wav');
      Add(FilesSectionStart);
      for i := 0 to FramesCount - 1 do
        Add(Frames[i].Path + Frames[i].FileName);
      Add(BookmarkSectionStart);
      for i := 0 to 9 do
        Add('Bookmark' + IntToStr(i) + ' = ' + IntToStr(Integer(Bookmarks[i])));
      Add(TeleportsSectionStart);
        for i := 0 to FramesCount - 1 do
          if Frames[i].Teleport <> -1 then
            Add(IntToStr(i) + ' = ' + IntToStr(Frames[i].Teleport));
      Add(FrameSectionStart);
      for i := 0 to RecordedFrames.Count - 1 do
        Add(IntToStr(Integer(RecordedFrames[i])));
      SaveToFile(SaveDialog.FileName);
      Saved := True;
    finally
      Free;
    end;
end;

procedure TMainForm.actSaveUpdate(Sender: TObject);
begin
  actSave.Enabled := not Exporting and not Saved;
end;

procedure TMainForm.actScreenWindowExecute(Sender: TObject);
begin
  if actFullScreenMode.Checked then
    actFullScreenMode.Execute;

  ScreenForm.Visible := actScreenWindow.Checked;
end;

procedure TMainForm.SetCaption(const Value: TCaption);
begin
  Caption := Value + ' - ' + Application.Title;
end;

procedure TMainForm.SetCurrentRecordPosition(const Value: Integer);
begin
  FCurrentRecordPosition := Value;
  if Playing then
    StockAudioPlayer.Position := MulDiv(CurrentRecordPosition, 1000, FrameRate);
end;

procedure TMainForm.SetFrameTipIndex(const Value: Integer);
begin
  FFrameTipIndex := Value;
  pbFrameTip.Visible := (FFrameTipIndex <> -1);
end;

procedure TMainForm.SetStatus(const Value: string);
begin
  StatusBar.SimpleText := Value;
end;

procedure TMainForm.SetCurrentFrameIndex(const Value: Integer);
begin
  FCurrentFrameIndex := Value;
  LoadPhoto(Value);
  if not Exporting then
    SetCaption(Frames[CurrentFrameIndex].Path +  Frames[CurrentFrameIndex].FileName);
//  pnlDisplay.Repaint;
//  pnlTimeLine.Repaint;
  pbDisplay.Repaint;
  if Assigned(ScreenForm) and ScreenForm.Visible then
    ScreenForm.Repaint;

  pbTimeLine.Repaint;
  if Assigned(ControllerForm) and ControllerForm.Visible then
    ControllerForm.Repaint;
end;

procedure TMainForm.StockAudioPlayerActivate(Sender: TObject);
begin
  // ��������� ��������������� ������ ����� ����, ��� ���� ����� ����� ����������������
  actPlay.Checked := True;
  ReplaceControlActions(caNone);
  UpdatePlayActions;
  // �� ������ ������. TODO ���� ��, ����� � actPlayExecute ���� ?
  if CurrentRecordPosition >= RecordedFrames.Count - 1 then
    CurrentRecordPosition := 0;
  Interval := 0;
  Playing := True;
end;

procedure TMainForm.StockAudioPlayerDeactivate(Sender: TObject);
begin
//  TODO: ������, ���� �� ������������� ��������������� ����� ��� ���������� �����
//  actPlay.Checked := False;
//
//  //CurrentRecordPosition := 0;
//  Interval := 0;
//  Playing := False;
end;

procedure TMainForm.LoadPhoto(Index: Integer);
var
  Image: TGraphic;
  R: TRect;
begin
  if (FramesCount = 0) or Frames[Index].Loaded or OutOfMemoryRaised then
    Exit;
  try
    with Frames[Index] do
      begin
        try
          Image := ImageFromDisc;
        except
          on e: Exception do
            Image := GenerateStubFrame(e.Message);
        end;
        Preview := TBitmap.Create;
        if actPreviewMode.Checked then
          begin
            R := StretchSize(Image.Width, Image.Height, 640, 480);
            {$IFDEF DelphiXE+}
            Preview.SetSize(640,480);
            {$ELSE}
            Preview.Width := 640;
            Preview.Height := 480;
            {$ENDIF}
            Preview.Canvas.StretchDraw(R, Image);
          end
        else
          Preview.Assign(Image);
        FreeAndNil(Image);
        Loaded := True;
      end;
  except
    on EOutOfResources do
      begin
        OutOfMemoryRaised := True;
        raise;
      end;
  end;
end;

procedure TMainForm.actToggleBookmarkExecute(Sender: TObject);
begin
  if Bookmarks[TMenuItem(Sender).Tag] = CurrentFrameIndex then
    Bookmarks[TMenuItem(Sender).Tag] := -1
  else
    Bookmarks[TMenuItem(Sender).Tag] := CurrentFrameIndex;
  pbTimeLine.Invalidate;
  Saved := False;
end;

procedure TMainForm.actToggleTeleport0Execute(Sender: TObject);
begin
  with Frames[CurrentFrameIndex] do
    if Teleport = TMenuItem(Sender).Tag then
      Teleport := -1
    else
      Teleport := TMenuItem(Sender).Tag;
  pbTimeLine.Invalidate;
  Saved := False;
end;

procedure TMainForm.actGotoBookmark0Execute(Sender: TObject);
begin
  if Bookmarks[TMenuItem(Sender).Tag] <> -1 then
    CurrentFrameIndex := Bookmarks[TMenuItem(Sender).Tag];
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actRecordExecute(Sender: TObject);
begin
  // ������ ������ �������� � AudioRecorderActivate
  // � ���������� - � AudioRecorderDeactivate
  AudioRecorder.Active := not Recording
end;

procedure TMainForm.pbDisplayDblClick(Sender: TObject);
begin
  actFullScreenMode.Execute;
end;

procedure TMainForm.pbDisplayPaint(Sender: TObject);
const
  MainScreenBorder = 10;
  PrevNextPreviewBorder = 5;
  PrevNextPreviewMaxSize = 120;
var
  R_MainScreen: TRect;
  R_PrevNextPreview: TRect;
  Offset: Integer;
  Image: TBitmap;
  Index: Integer;
begin
  try
    pbDisplay.Canvas.Brush.Color := clWhite;
    pbDisplay.Canvas.FillRect(pbDisplay.ClientRect);
    pbDisplay.Canvas.Brush.Color := clBtnFace;

    LoadPhoto(CurrentFrameIndex); // �� ������ ������
    if FramesCount = 0 then
      begin
        R_MainScreen.Left := (pbDisplay.Width  - imgBackgroundSource.Picture.Width ) div 2;
        R_MainScreen.Top  := (pbDisplay.Height - imgBackgroundSource.Picture.Height) div 2;
        pbDisplay.Canvas.Draw(R_MainScreen.Left, R_MainScreen.Top, imgBackgroundSource.Picture.Graphic);
        Exit;
      end;
    Index := IncrementCurrentFrameIndex(-1);
    LoadPhoto(Index); // �� ������ ������
    if Frames[Index].Loaded then
      begin
        Image := Frames[Index].Preview;
        R_PrevNextPreview := StretchSize(Image.Width, Image.Height, PrevNextPreviewMaxSize, PrevNextPreviewMaxSize);
      end;
    if Frames[CurrentFrameIndex].Loaded then
      begin
        Image := Frames[CurrentFrameIndex].Preview;
        if actStretchImages.Checked or (Image.Width > (pbDisplay.Width - MainScreenBorder * 2)) or (Image.Height > (pbDisplay.Height - MainScreenBorder * 2)) then
          begin
            R_MainScreen := StretchSize(Image.Width, Image.Height, pbDisplay.Width - MainScreenBorder * 2, pbDisplay.Height - MainScreenBorder * 2);
            R_MainScreen.Left   := R_MainScreen.Left   + MainScreenBorder;
            R_MainScreen.Top    := R_MainScreen.Top    + MainScreenBorder;
            R_MainScreen.Right  := R_MainScreen.Right  + MainScreenBorder;
            R_MainScreen.Bottom := R_MainScreen.Bottom + MainScreenBorder;

            Offset := Min(pbDisplay.Height - MainScreenBorder * 2 - R_MainScreen.Bottom, (R_PrevNextPreview.Bottom - R_PrevNextPreview.Top - MainScreenBorder) div 2);

            R_MainScreen.Top    := R_MainScreen.Top    + Offset + MainScreenBorder;
            R_MainScreen.Bottom := R_MainScreen.Bottom + Offset + MainScreenBorder;

            with R_MainScreen do
              pbDisplay.Canvas.RoundRect(
                Left   - MainScreenBorder,
                Top    - MainScreenBorder,
                Right  + MainScreenBorder,
                Bottom + MainScreenBorder,
                MainScreenBorder,
                MainScreenBorder
              );
            pbDisplay.Canvas.StretchDraw(R_MainScreen, Image);
          end
        else
          begin
            R_MainScreen.Left := (pbDisplay.Width  - Image.Width ) div 2;
            R_MainScreen.Top  := (pbDisplay.Height - Image.Height) div 2;
            R_MainScreen.Right := R_MainScreen.Left + Image.Width;
            R_MainScreen.Bottom := R_MainScreen.Top + Image.Height;
            with R_MainScreen do
              pbDisplay.Canvas.RoundRect(
                Left   - MainScreenBorder,
                Top    - MainScreenBorder,
                Right  + MainScreenBorder,
                Bottom + MainScreenBorder,
                MainScreenBorder,
                MainScreenBorder
              );
            pbDisplay.Canvas.Draw(R_MainScreen.Left, R_MainScreen.Top, Image);
          end;
      end;
    Index := IncrementCurrentFrameIndex(-1);
    LoadPhoto(Index); // �� ������ ������
    if Frames[Index].Loaded then
      begin
        Image := Frames[Index].Preview;
        R_PrevNextPreview.Bottom := R_PrevNextPreview.Bottom - R_PrevNextPreview.Top;
        R_PrevNextPreview.Top    := 0;
        R_PrevNextPreview.Left   := R_PrevNextPreview.Left   + PrevNextPreviewBorder;
        R_PrevNextPreview.Top    := R_PrevNextPreview.Top    + PrevNextPreviewBorder;
        R_PrevNextPreview.Right  := R_PrevNextPreview.Right  + PrevNextPreviewBorder;
        R_PrevNextPreview.Bottom := R_PrevNextPreview.Bottom + PrevNextPreviewBorder;
        with R_PrevNextPreview do
          pbDisplay.Canvas.RoundRect(
            Left   - PrevNextPreviewBorder,
            Top    - PrevNextPreviewBorder,
            Right  + PrevNextPreviewBorder,
            Bottom + PrevNextPreviewBorder,
            PrevNextPreviewBorder,
            PrevNextPreviewBorder
          );
        pbDisplay.Canvas.StretchDraw(R_PrevNextPreview, Image);
      end;
    Index := IncrementCurrentFrameIndex(+1);
    LoadPhoto(Index); // �� ������ ������
    if Frames[Index].Loaded then
      begin
        Image := Frames[Index].Preview;
        R_PrevNextPreview := StretchSize(Image.Width, Image.Height, PrevNextPreviewMaxSize, PrevNextPreviewMaxSize);
        R_PrevNextPreview.Left := pbDisplay.Width - PrevNextPreviewMaxSize + R_PrevNextPreview.Left;
        R_PrevNextPreview.Right := pbDisplay.Width - PrevNextPreviewMaxSize + R_PrevNextPreview.Right;
        R_PrevNextPreview.Bottom := R_PrevNextPreview.Bottom - R_PrevNextPreview.Top;
        R_PrevNextPreview.Top := 0;
        R_PrevNextPreview.Left   := R_PrevNextPreview.Left   - PrevNextPreviewBorder;
        R_PrevNextPreview.Top    := R_PrevNextPreview.Top    + PrevNextPreviewBorder;
        R_PrevNextPreview.Right  := R_PrevNextPreview.Right  - PrevNextPreviewBorder;
        R_PrevNextPreview.Bottom := R_PrevNextPreview.Bottom + PrevNextPreviewBorder;
        with R_PrevNextPreview do
          pbDisplay.Canvas.RoundRect(
            Left   - PrevNextPreviewBorder,
            Top    - PrevNextPreviewBorder,
            Right  + PrevNextPreviewBorder,
            Bottom + PrevNextPreviewBorder,
            PrevNextPreviewBorder,
            PrevNextPreviewBorder
          );
        pbDisplay.Canvas.StretchDraw(R_PrevNextPreview, Image);
      end;
  except
    ; // �� ������ ������ ������ ������ ���������, ������ ��� ��� ��������� ������ �����
  end;
end;

procedure TMainForm.pbFrameTipPaint(Sender: TObject);
begin
  if FrameTipIndex <> -1 then
    if FrameTipMode = ftmTimeLine then
      begin
        pbFrameTip.Canvas.Polygon([
          Point(0, 0),
          Point(0, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipArrow-FrameTipD, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipArrow, FrameTipH+FrameTipT+FrameTipT+FrameTipD+FrameTipD),
          Point(FrameTipArrow+FrameTipD, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipW+FrameTipT+FrameTipT, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipW+FrameTipT+FrameTipT, 0)
        ]);
        pbFrameTip.Canvas.StretchDraw(Rect(FrameTipT, FrameTipT, FrameTipW+FrameTipT+FrameTipT, FrameTipH+FrameTipT+FrameTipT), Frames[FrameTipIndex].Preview);
      end
    else
      begin
        pbFrameTip.Canvas.Polygon([
          Point(0, 0),
          Point(0, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipW+FrameTipT+FrameTipT, FrameTipH+FrameTipT+FrameTipT),
          Point(FrameTipW+FrameTipT+FrameTipT, FrameTipArrow + FrameTipD),
          Point(FrameTipW+FrameTipT+FrameTipT+FrameTipD+FrameTipD, FrameTipArrow),
          Point(FrameTipW+FrameTipT+FrameTipT, FrameTipArrow - FrameTipD),
          Point(FrameTipW+FrameTipT+FrameTipT, 0)
        ]);
        pbFrameTip.Canvas.StretchDraw(Rect(FrameTipT, FrameTipT, FrameTipW+FrameTipT+FrameTipT, FrameTipH+FrameTipT+FrameTipT), Frames[FrameTipIndex].Preview);
      end;
end;

var
  OddTick: Boolean;

procedure TMainForm.pbIndicatorPaint(Sender: TObject);
var
//  X: TPoint;
  a: Double;
begin
  with pbIndicator, Canvas do
    begin
      Pen.Style := psClear;
      Brush.Style := bsClear;
      SetTextAlign(Handle, TA_TOP + TA_CENTER);
      TextOut(15, 8, IntToStr(CurrentSpeedInterval) + '/' + IntToStr(FrameRate));
      Brush.Style := bsSolid;
      Brush.Color := clBlack;
      if Playing then
        a := -(CurrentRecordPosition mod FrameRate)* 2 * Pi / FrameRate
      else
        a := -(RecordedFrames.Count mod FrameRate)* 2 * Pi / FrameRate;
      with Point(15 + Round(10 * Cos(a)), 15 - Round(10 * Sin(a))) do
        Ellipse(X-2, Y-2, X+3, Y+3);

      a := -(GetTickCount mod 1000)* 2 * Pi / 1000; // ������� �����������. ������ 25 ��� � ������� ����������������.
      with Point(15 + Round(10 * Cos(a)), 15 - Round(10 * Sin(a))) do
        FillRect(Rect(X-1, Y-1, X+2, Y+2));

      Pen.Style := psSolid;
      Pen.Color := clBlack;
      Pen.Width := 2;
      if OddTick then
        begin
          MoveTo(45 - 1, 25);
          LineTo(45 - 5, 5)
        end
      else
        begin
          MoveTo(45 + 1, 25);
          LineTo(45 + 5, 5);
        end;
      OddTick := not OddTick;
      Pen.Width := 1;
      Polyline([
        Point(45-2, 7),
        Point(45+2, 7),
        Point(45+5, 30-3),
        Point(45-5, 30-3),
        Point(45-2, 7)
      ]);

      FillRect(Rect(0, Height - 2, NextControlActionStackPosition * 2, Height));
    end;
end;

procedure TMainForm.pbRecordMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  NewPosition: Integer;
begin
  if RecordedFrames.Count = 0 then
    Exit;

  NewPosition := Y + pbRecordOffset;
  if NewPosition >= RecordedFrames.Count then
    NewPosition := RecordedFrames.Count - 1;
  if NewPosition < 0 then
    NewPosition := 0;

  CurrentRecordPosition := NewPosition;
  CurrentFrameIndex := Integer(RecordedFrames[CurrentRecordPosition]);

  pbRecord.Invalidate;
  pbDisplay.Invalidate;
  UpdateActions;
end;

procedure TMainForm.pbRecordMouseLeave(Sender: TObject);
begin
  FrameTipIndex := -1;
end;

procedure TMainForm.pbRecordMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  LocalCurrentRecordPosition: Integer;
begin
  if ssLeft in Shift then
    pbRecordMouseDown(Sender, mbLeft, Shift, X, Y);

  LocalCurrentRecordPosition := Y + pbRecordOffset;
  if (LocalCurrentRecordPosition >= RecordedFrames.Count) or (LocalCurrentRecordPosition < 0) then
    FrameTipIndex := -1
  else
    begin
      FrameTipIndex := Integer(RecordedFrames[LocalCurrentRecordPosition]);
      FrameTipMode := ftmRecord;
      pbFrameTip.Width  := FrameTipT + FrameTipW + FrameTipD + FrameTipD + FrameTipT + 1;
      pbFrameTip.Height := FrameTipT + FrameTipH + FrameTipT + 1;
      pbFrameTip.Left := pbDisplay.Width - pbFrameTip.Width;
      pbFrameTip.Top  := Min(Max(0, Y - pbFrameTip.Height div 2), pbDisplay.Height - pbFrameTip.Height);
      FrameTipArrow := Y - pbFrameTip.Top;
    end;
  pbFrameTip.Invalidate;
end;

procedure TMainForm.pbRecordPaint(Sender: TObject);
type
  TSampleArray = array [0..256] of SmallInt;
  PSampleArray = ^TSampleArray;
var
  y: Integer;
  FrameIndex: Integer;
  R: TRect;
  DataWidth: Integer;
  DataAreaHeight: Integer;

  SamplesPerFrame: Integer;
  WaveFormat: TWaveFormatEx;

  procedure DrawSound;
  var
    FirstSample: Integer;
    pSample: PSmallInt;
    MaxData, MinData: SmallInt;
    i: Integer;
  begin
    FirstSample := FrameIndex * SamplesPerFrame;
    if (FirstSample + SamplesPerFrame) > (RecordedAudioCopy.Size div 2) then
      Exit;

    pSample := Pointer(PSampleArray(RecordedAudioCopy.Memory));
    inc(pSample, FirstSample);
    MaxData := PWordArray(pSample)^[0];
    MinData := pSample^;
    for i := 0 to SamplesPerFrame - 1 do
      begin
        MaxData := Max(MaxData, pSample^);
        MinData := Min(MinData, pSample^);
        Inc(pSample);
        Inc(pSample); // stereo
      end;
    pbRecord.Canvas.MoveTo(R.Left + DataWidth div 2 + MulDiv(MinData, DataWidth, $FFFF div 2),     y);
    pbRecord.Canvas.LineTo(R.Left + DataWidth div 2 + MulDiv(MaxData, DataWidth, $FFFF div 2) + 1, y);
  end;

  procedure DrawScaleMark;
  begin
    if FrameIndex mod FrameRate        = 0 then pbRecord.Canvas.FillRect(Rect(R.Left, y, R.Right, y + 1));
    if FrameIndex mod (FrameRate * 10) = 0 then pbRecord.Canvas.FillRect(Rect(R.Left, y, R.Right, y + 2));
    if FrameIndex mod (FrameRate * 60) = 0 then pbRecord.Canvas.FillRect(Rect(R.Left, y, R.Right, y + 3));
  end;

begin
  DataWidth := pbRecord.ClientWidth - 12;
  DataAreaHeight := pbRecord.ClientHeight - 10;

  pbRecordOffset := CurrentRecordPosition - (DataAreaHeight div 2);
  if (pbRecordOffset + DataAreaHeight) > RecordedFrames.Count then
    pbRecordOffset := RecordedFrames.Count - DataAreaHeight;
  if pbRecordOffset < 0 then
    pbRecordOffset := 0;

  SetPCMAudioFormatS(@WaveFormat, AudioRecorder.PCMFormat);

  SamplesPerFrame := 2 * (WaveFormat.nSamplesPerSec div FrameRate);
  Assert(WaveFormat.wBitsPerSample = 16, '{F90018C7-D187-41DE-A30C-CB8D15A72149}');
  Assert(WaveFormat.nChannels = 2,       '{9655AC01-69A1-456D-B55E-027A9B04CA93}');

  pbRecord.Canvas.Brush.Color := clBtnFace;
  pbRecord.Canvas.FillRect(pbRecord.ClientRect);

  pbRecord.Canvas.Brush.Color := clMaroon;
  with pbRecord.ClientRect do pbRecord.Canvas.FillRect(Rect(
    Right - 2, MulDiv(pbRecordOffset, pbRecord.ClientHeight, RecordedFrames.Count),
    Right, MulDiv(pbRecordOffset + DataAreaHeight, pbRecord.ClientHeight, RecordedFrames.Count)
  ));

  pbRecord.Canvas.Pen.Color := clBlack;
  pbRecord.Canvas.Pen.Width := 1;
  pbRecord.Canvas.Pen.Style := psSolid;

  R := pbRecord.ClientRect;
  R.Bottom := Min(RecordedFrames.Count - pbRecordOffset + 10, R.Bottom);
  R.Right := R.Left + DataWidth + 10;
  pbRecord.Canvas.Brush.Color := clBtnFace;
  pbRecord.Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 5, 5);
  R.Left   := R.Left   + 5;
  R.Top    := R.Top    + 5;
  R.Right  := R.Right  - 5;
  R.Bottom := R.Bottom - 5;
  pbRecord.Canvas.Brush.Color := clWindow;
  pbRecord.Canvas.FillRect(R);

  pbRecord.Canvas.Brush.Color := clLtGray;

  pbRecord.Canvas.Pen.Color := clSkyBlue;
  pbRecord.Canvas.Pen.Width := 1;
  pbRecord.Canvas.Pen.Style := psSolid;

  FrameIndex := pbRecordOffset;
  for y := R.Top to R.Bottom - 1 do
    begin
      DrawSound;

      DrawScaleMark;

      pbRecord.Canvas.Pixels[R.Left + MulDiv(Integer(RecordedFrames[FrameIndex]), DataWidth, FramesCount - 1), y] := clBlack;

      Inc(FrameIndex);
    end;

  pbRecord.Canvas.Brush.Color := clWhite;
    if CurrentRecordPosition < RecordedFrames.Count then
      with Point(MulDiv(Integer(RecordedFrames[CurrentRecordPosition]), DataWidth, FramesCount - 1) + R.Left, CurrentRecordPosition - pbRecordOffset + R.Top) do
        pbRecord.Canvas.Ellipse(x-2, y-2, x+3, y+3);
end;

procedure TMainForm.ListBoxClick(Sender: TObject);
begin
//  CurrentFrameIndex := ListBox.ItemIndex;
end;

procedure TMainForm.LiveAudioRecorderData(Sender: TObject; const Buffer: Pointer; BufferSize: Cardinal; var FreeIt: Boolean);
type
  TVolumeArray = array [0..1600] of Byte;
var
  MaxVolume: Integer;
  i: Integer;
  Volumes: ^TVolumeArray;
begin
  // ������ ��������� 200 ���������� ����� � ���������.
  // ��������� ��������, � �������� ���.
  Volumes := Buffer;
  MaxVolume := 0;
  for i := 0 to BufferSize - 1 do
    if MaxVolume < Abs(Volumes^[i] - 128) then
      MaxVolume := Abs(Volumes^[i] - 128);
  LevelGauge.Progress := Round(MaxVolume / 128 * 100);
end;

procedure TMainForm.pbTimeLineMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  NewFrameIndex: Integer;
begin
  if FramesCount = 0 then
    Exit;

  NewFrameIndex := TimeLineXToFrameIndex(X);
  if NewFrameIndex >= FramesCount then
    NewFrameIndex := FramesCount - 1;
  if NewFrameIndex < 0 then
    NewFrameIndex := 0;

  CurrentFrameIndex := NewFrameIndex;

  pbRecord.Invalidate;
  pbDisplay.Invalidate;
  UpdateActions;
end;

procedure TMainForm.pbTimeLineMouseLeave(Sender: TObject);
begin
  FrameTipIndex := -1;
end;

procedure TMainForm.pbTimeLineMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then
    pbTimeLineMouseDown(Sender, mbLeft, Shift, X, Y);

  FrameTipIndex := TimeLineXToFrameIndex(X);
  FrameTipMode := ftmTimeLine;
  pbFrameTip.Width  := FrameTipT + FrameTipW + FrameTipT + 1;
  pbFrameTip.Height := FrameTipT + FrameTipH + FrameTipD + FrameTipD + FrameTipT + 1;
  pbFrameTip.Top  := pnlDisplay.Height - pbFrameTip.Height;
  pbFrameTip.Left := Min(Max(0, X - pbFrameTip.Width div 2), pnlDisplay.Width - pbFrameTip.Width);
  FrameTipArrow := FrameIndexToTimeLineX(FrameTipIndex) - pbFrameTip.Left;

  pbFrameTip.Invalidate;
end;

function TMainForm.FrameIndexToTimeLineX(FrameIndex: Integer): Integer;
begin
  if FramesCount = 0 then
    Result := -1
  else
    Result := 4 + MulDiv(FrameIndex, pbTimeLine.Width - 8, FramesCount - 1);
end;

function TMainForm.TimeLineXToFrameIndex(X: Integer): Integer;
begin
  if FramesCount = 0 then
    Result := -1
  else
    begin
      Result := MulDiv(X - 4, FramesCount, pbTimeLine.Width - 8);

      if Result >= FramesCount then
        Result := FramesCount - 1;
      if Result < 0 then
        Result := 0;
    end;
end;

procedure TMainForm.pbTimeLinePaint(Sender: TObject);
var
  SecondIndex: Integer;
  FrameIndex: integer;
  BookmarkIndex: Integer;
  x, y1, y2: Integer;
  BookmarkText: string;
  BookmarkRect: TRect;
  TextSize: TSize;
begin
  y1 := 4;

  for SecondIndex := 0 To FramesCount * CurrentSpeedInterval div FrameRate - 1 do
    begin
      x := 4 + MulDiv(pbTimeLine.Width - 8, SecondIndex, FramesCount * CurrentSpeedInterval div FrameRate);
      pbTimeLine.Canvas.Brush.Style := bsSolid;
      pbTimeLine.Canvas.Rectangle(x, y1 + 8, x+1, y1 + 16);
    end;

  for FrameIndex := 0 to FramesCount - 1 do
    begin
      x := FrameIndexToTimeLineX(FrameIndex);
      if Frames[FrameIndex].Loaded then
        y2 := y1 + 8
      else
        y2 := y1 + 4;

      pbTimeLine.Canvas.Brush.Style := bsSolid;
      if FrameIndex <> CurrentFrameIndex then
        pbTimeLine.Canvas.Rectangle(x, y1, x+1, y2)
      else
        begin
          pbTimeLine.Canvas.Brush.Color := clHighlight;
          pbTimeLine.Canvas.Rectangle(x-1, y1, x+2, y2);
        end;

      for BookmarkIndex := 0 to 9 do
        if FrameIndex = Bookmarks[BookmarkIndex] then
        begin
          BookmarkText := IntToStr(BookmarkIndex);
          BookmarkRect := Rect(x - 20, y1, x + 21, pbTimeLine.Height);
//          pbTimeLine.Canvas.TextRect(BookmarkRect, BookmarkText, [tfNoClip, tfLeft, tfTop, tfCalcRect]);
//          BookmarkRect := Rect(x - (BookmarkRect.Right - BookmarkRect.Left) div 2 - 2, y1 - 2, x + (BookmarkRect.Right - BookmarkRect.Left) div 2 + 2, BookmarkRect.Bottom);
          TextSize := pbTimeLine.Canvas.TextExtent(BookmarkText);
          BookmarkRect := Rect(x - TextSize.cx div 2 - 2, y1 - 2, x + TextSize.cx div 2 + 2, y1 + TextSize.cy);
          pbTimeLine.Canvas.Brush.Style := bsSolid;
          if FrameIndex = CurrentFrameIndex then
          begin
            pbTimeLine.Canvas.Brush.Color := clHighlight;
            pbTimeLine.Canvas.Font.Color := clHighlightText;
          end
          else
          begin
            pbTimeLine.Canvas.Brush.Color := clBtnFace;
            pbTimeLine.Canvas.Brush.Style := bsSolid;
            pbTimeLine.Canvas.Font.Color := clBtnText;
          end;
          with BookmarkRect do
            pbTimeLine.Canvas.RoundRect(Left, Top, Right, Bottom, 2, 2);
          Inc(BookmarkRect.Left, 2);
          pbTimeLine.Canvas.Brush.Style := bsClear;
//          pbTimeLine.Canvas.TextRect(BookmarkRect, BookmarkText, [tfNoClip, tfLeft, tfTop]);
          pbTimeLine.Canvas.TextOut(BookmarkRect.Left, BookmarkRect.Top, BookmarkText);
        end;

      if Frames[FrameIndex].Teleport <> -1 then
        begin
          BookmarkText := IntToStr(Frames[FrameIndex].Teleport);
          BookmarkRect := Rect(x - 20, y1, x + 21, pbTimeLine.Height);
//          pbTimeLine.Canvas.TextRect(BookmarkRect, BookmarkText, [tfNoClip, tfLeft, tfTop, tfCalcRect]);
//          BookmarkRect := Rect(x - (BookmarkRect.Right - BookmarkRect.Left) div 2 - 2, y1 - 2, x + (BookmarkRect.Right - BookmarkRect.Left) div 2 + 2, BookmarkRect.Bottom);
          TextSize := pbTimeLine.Canvas.TextExtent(BookmarkText);
          BookmarkRect := Rect(x - TextSize.cx div 2 - 2, y1 - 2, x + TextSize.cx div 2 + 2, y1 + TextSize.cy);
          pbTimeLine.Canvas.Brush.Style := bsSolid;
          if not TeleportEnabled or (Bookmarks[Frames[FrameIndex].Teleport] = -1) then
            begin
              pbTimeLine.Canvas.Brush.Color := clLtGray;
              pbTimeLine.Canvas.Font.Color := clDkGray;
            end
          else if FrameIndex = CurrentFrameIndex then
            begin
              pbTimeLine.Canvas.Brush.Color := clLime;
              pbTimeLine.Canvas.Font.Color := clBlack;
            end
          else
            begin
              pbTimeLine.Canvas.Brush.Color := clGreen;
              pbTimeLine.Canvas.Brush.Style := bsSolid;
              pbTimeLine.Canvas.Font.Color := clWhite;
            end;
          with BookmarkRect do
            pbTimeLine.Canvas.RoundRect(Left, Top, Right, Bottom, 2, 2);
          Inc(BookmarkRect.Left, 2);
          pbTimeLine.Canvas.Brush.Style := bsClear;
//          pbTimeLine.Canvas.TextRect(BookmarkRect, BookmarkText, [tfNoClip, tfLeft, tfTop]);
          pbTimeLine.Canvas.TextOut(BookmarkRect.Left, BookmarkRect.Top, BookmarkText);
        end;
    end;
end;

procedure TMainForm.PopControlAction;
begin
  Assert(NextControlActionStackPosition >=1, '{EBDE522B-9ED0-474F-9F3F-4C5CAEDBC757}');
  Dec(NextControlActionStackPosition);
end;

procedure TMainForm.PushControlAction(Value: TControlAction);
begin
  // ���� ���� ����������, �� �� ���������� �, � �������.
  if NextControlAction in [caPlayBackward, caPlayForward] then
    NextControlActionStackPosition := 0;

  if NextControlActionStackPosition = ControlActionStackDeep then
    Beep
  else
    Inc(NextControlActionStackPosition);
  NextControlActionStack[NextControlActionStackPosition] := Value;
end;

procedure TMainForm.RecalculatePreview;
var
  i: Integer;
begin
  for i := 0 to FramesCount - 1 do
    if Frames[i].Loaded then
      begin
        Frames[i].Loaded := False;
//        FreeAndNil(Frames[i].OriginalJpeg);
        FreeAndNil(Frames[i].Preview);
        OutOfMemoryRaised := False;
      end;
end;

procedure TMainForm.ReplaceControlActions(Value: TControlAction);
begin
  NextControlActionStackPosition := 1;
  NextControlActionStack[NextControlActionStackPosition] := Value;
end;

function TMainForm.TeleportEnabled: Boolean;
begin
  Result := not ((GetAsyncKeyState(vk_Shift) < 0) xor (GetKeyState(VK_CAPITAL) and 1 = 1)); // ���� ��, ���� ������...
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  if (FramesCount = 0) then
    Exit;

  if Exporting then
    Exit;
  if Playing then
    begin
      if CurrentRecordPosition < RecordedFrames.Count then
        begin
          CurrentFrameIndex := Integer(RecordedFrames[CurrentRecordPosition]);
          pbRecord.Invalidate;
          Inc(FCurrentRecordPosition);
        end
      else
        if LoopMode then
          CurrentRecordPosition := 0
        else
          Playing := False;
    end
  else
    begin
      case NextControlAction of
        caStepForward:
          begin
            CurrentFrameIndex := IncrementCurrentFrameIndex(1);
            PopControlAction;
          end;
        caPlayForward:
          if Interval <= 1 then
            CurrentFrameIndex := IncrementCurrentFrameIndex(1);
        caStepBackward:
          begin
            CurrentFrameIndex := IncrementCurrentFrameIndex(-1);
            PopControlAction;
          end;
        caPlayBackward:
          if Interval <= 1 then
            CurrentFrameIndex := IncrementCurrentFrameIndex(-1);
        caNone:
          if Interval <= 1 then
            begin
              if actBackwardWhilePressed.Checked or (GetAsyncKeyState(Ord('A')) < 0) or (GetAsyncKeyState(Ord('C')) < 0) then //  ��� ����� ��� ��������� � ���� � � ������������ ������� ������ IsShortCut
                CurrentFrameIndex := IncrementCurrentFrameIndex(-1);
              if actForwardWhilePressed.Checked or (GetAsyncKeyState(Ord('D')) < 0)  or (GetAsyncKeyState(Ord('M')) < 0) then
                CurrentFrameIndex := IncrementCurrentFrameIndex(1);
            end;
      end;

      if Recording then
        begin
          RecordedFrames.Add(Pointer(CurrentFrameIndex));
          pbRecord.Invalidate;
          CurrentRecordPosition := RecordedFrames.Count - 1;
        end;

      if Interval <= 1 then
        begin
          Interval := CurrentSpeedInterval;
          pbIndicator.Repaint;
        end
      else
        dec(Interval);
    end;
end;

procedure TMainForm.tlbNavigationMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // fix auto chande Down in ToolbarButtons with style Check
  btnPlayForward.Down  := actPlayForward.Checked;
  btnPlayBackward.Down := actPlayBackward.Checked;
end;

procedure TMainForm.actPlayBackwardExecute(Sender: TObject);
begin
  if NextControlAction <> caPlayBackward then
    ReplaceControlActions(caPlayBackward)
  else
    ReplaceControlActions(caNone);
  UpdatePlayActions;
end;

procedure TMainForm.actNavigate_Update(Sender: TObject);
begin
  TAction(Sender).Enabled := not Exporting and (FramesCount > 0);
end;

procedure TMainForm.actUpdate_HaveRecorded(Sender: TObject);
begin
  TAction(Sender).Enabled := not Exporting and (RecordedFrames.Count > 0);
end;

procedure TMainForm.actStepNextExecute(Sender: TObject);
begin
  PushControlAction(caStepForward);
  UpdatePlayActions;
end;

procedure TMainForm.actStepPrevExecute(Sender: TObject);
begin
  PushControlAction(caStepBackward);
  UpdatePlayActions;
end;

procedure TMainForm.actStretchImagesExecute(Sender: TObject);
begin
  pbDisplay.Invalidate;
end;

procedure TMainForm.actPlayForwardExecute(Sender: TObject);
begin
  if NextControlAction <> caPlayForward then
    ReplaceControlActions(caPlayForward)
  else
    ReplaceControlActions(caNone);
  UpdatePlayActions;
end;

procedure TMainForm.UpdatePlayActions;
begin
  actPlayForward.Checked := (NextControlAction = caPlayForward);
  actPlayBackward.Checked := (NextControlAction = caPlayBackward);
end;

procedure TMainForm.actPlayUpdate(Sender: TObject);
begin
  actPlay.Enabled := not Exporting and (RecordedFrames.Count > 0);
  actPlay.Checked := Playing;
end;

procedure TMainForm.actPlayExecute(Sender: TObject);
begin
  if Recording then
    begin
      actRecord.Execute;
      AudioRecorder.WaitForStop;
    end;

  Playing := not Playing; // ��� ����� ���������� CurrentRecordPosition, ����� � ��� ������������ � ������� �����.
  if CurrentRecordPosition >= RecordedFrames.Count then
    CurrentRecordPosition := 0
  else
    CurrentRecordPosition := CurrentRecordPosition; // ������ ���������������� �����. TODO: ��� ��������� ���-��...

  StockAudioPlayer.Active := Playing;
  // ������ ������ ��������������� � ����������� ��������� -
  // ����� ����������� StockAudioPlayerActivate � StockAudioPlayerDeactivate:
  // ��������� ��������������� ������ ������ ����� ����, ��� ���� ����� ����� ����������������.
  // �� ��� ������������� �������, �� ������ ������, ����� �����, � �� ����� ���� ���������.
  if not Playing then
    begin
      actPlay.Checked := False;

      //CurrentRecordPosition := 0;
      Interval := 0;
    end;
end;

procedure TMainForm.ApplicationIdle(Sender: TObject; var Done: Boolean);
resourcestring
  rs_PreloadStatus = '�������� �����: ';
var
  i: integer;
begin
  Done := True;
  if not OutOfMemoryRaised then
    for i := 0 to FramesCount - 1 do
      if not Frames[i].Loaded then
        begin
          SetStatus(rs_PreloadStatus + Frames[i].Path + Frames[i].FileName);
          LoadPhoto(i);
          pbTimeLine.Repaint;
          Done := False;
          Exit;
        end;
  if Done then
    SetStatus('');
end;

procedure TMainForm.AudioRecorderActivate(Sender: TObject);
begin
  Recording := True;
  actRecord.Checked := True;
end;

procedure TMainForm.AudioRecorderDeactivate(Sender: TObject);
begin
  Recording := False;
  actRecord.Checked := False;
  ReplaceControlActions(caNone);

  UpdatePlayActions;

  if WaveStorage.Wave.Empty then
    WaveStorage.Wave.Assign(AudioRecorder.Wave)
  else
    WaveStorage.Wave.Insert(MAXDWORD, AudioRecorder.Wave);
  AudioRecorder.Wave.Clear;
  Saved := False;
end;

procedure TMainForm.AudioRecorderFilter(Sender: TObject; const Buffer: Pointer;
  BufferSize: Cardinal);
begin
  RecordedAudioCopy.Write(Buffer^, BufferSize);
end;

procedure TMainForm.btnBackwardWhilePressedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  actBackwardWhilePressed.Checked := True;
end;

procedure TMainForm.btnBackwardWhilePressedMouseLeave(Sender: TObject);
begin
  actBackwardWhilePressed.Checked := False;
end;

procedure TMainForm.btnBackwardWhilePressedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  actBackwardWhilePressed.Checked := False;
end;

procedure TMainForm.btnForwardWhilePressedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  actForwardWhilePressed.Checked := True;
end;

procedure TMainForm.btnForwardWhilePressedMouseLeave(Sender: TObject);
begin
  actForwardWhilePressed.Checked := False;
end;

procedure TMainForm.btnForwardWhilePressedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  actForwardWhilePressed.Checked := False;
end;

procedure TMainForm.btnNavigationMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TToolButton(Sender).Click;
end;

procedure TMainForm.pbIndicatorClick(Sender: TObject);
begin
  mmiDoubleFramerate.Click;
end;

function TMainForm.IncrementCurrentFrameIndex(AOffset: Integer): Integer;
var
  Count: Integer;
  i: Integer;
begin
  Result := CurrentFrameIndex;
  if AOffset = 0 then
    Exit;

  if FramesCount = 0 then
    begin
      Result := 0;
      Exit;
    end;

  // TODO: Stop frames. Stop frames must break this incrementing

  Count := Abs(AOffset);
  AOffset := AOffset div Count;
  for i := 1 to Count do
    begin
      Result := Result + AOffset;
      while Result < 0 do
        Result := FramesCount + Result;
      while Result > (FramesCount - 1) do
        Result := Result - FramesCount;

      if TeleportEnabled and (Frames[Result].Teleport <> -1) and (Bookmarks[Frames[Result].Teleport] <> -1) then
        Result := Bookmarks[Frames[Result].Teleport];
    end;
end;

function TMainForm.IsShortCut(var Message: {$IFDEF FPC}TLMKey{$ELSE}TWMKey{$ENDIF}): Boolean;
begin
  if (Message.CharCode <> vk_Left)
    and (Message.CharCode <> vk_Right)
    and (Message.CharCode <> ord('A')) and (Message.CharCode <> ord('C'))
    and (Message.CharCode <> ord('D')) and (Message.CharCode <> ord('M'))
  then
    begin
      Result := inherited IsShortCut(Message);
      // Full Screen menu shortcuts (bookmarks)
      if not Result and (Menu = nil) then
        Result := MainMenu.IsShortCut(Message);
    end
  else
    Result := False;
end;

procedure TMainForm.ClearRecorded;
begin
  WaveStorage.Wave.Clear;
  RecordedAudioCopy.Clear;
  RecordedFrames.Clear;
  FCurrentRecordPosition := 0;
end;

{ TFrame }

constructor TFrame.Create(APath, AFileName: string);
begin
  FPath := APath;
  FFileName := AFileName;
  Teleport := -1;
end;

destructor TFrame.Destroy;
begin
//  FreeAndNil(OriginalJpeg);
  FreeAndNil(Preview);
  inherited;
end;

function TFrame.ImageFromDisc: TGraphic;
begin
  Result := TJPEGImage.Create;
  with TJPEGImage(Result) do
    begin
      LoadFromFile(MainForm.PhotoFolder + Path + FileName); // NOTE: Global variable used
      Performance := jpBestSpeed;
      {$IFNDEF FPC}DIBNeeded;{$ENDIF}
    end;
end;

function TFrame.GenerateStubFrame(ErrorMessage: string): TGraphic;
begin
  Result := TBitmap.Create;
  with TBitmap(Result) do
    begin
      {$IFDEF DelphiXE+}
      SetSize(640,480);
      {$ELSE}
      Width := 640;
      Height := 480;
      {$ENDIF}
      Canvas.TextOut(20, 20, Path + FileName);
      Canvas.TextOut(20, 80, ErrorMessage);
    end;
end;

end.
