unit ServerHl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, OraCall, Data.DB, DBAccess, Ora, Vcl.StdCtrls,
  IdContext,IdGlobal, Vcl.DBCtrls, MemDS;

type
  TForm13 = class(TForm)
    OraSession1: TOraSession;
    IdTCPServer1: TIdTCPServer;
    CheckBoxConnectDisconnet: TCheckBox;
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    procedure CheckBoxConnectDisconnetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Parsing(Char, Str: string; Count: Integer): string;
    function Parsing1(Char, Str: string; Count: Integer): string;
    function Parsing2(Char, Str: string; Count: Integer): string;
    procedure ParseEt();

  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.Button1Click(Sender: TObject);
begin
ParseEt();
end;

procedure TForm13.CheckBoxConnectDisconnetClick(Sender: TObject);
begin
  if ( CheckBoxConnectDisconnet.Checked = True ) then
    IdTCPServer1.Active := True
  else
    IdTCPServer1.Active := False;
end;
procedure TForm13.FormCreate(Sender: TObject);
begin
  IdTCPServer1.Bindings.Add.IP   := '127.0.0.1';
  IdTCPServer1.Bindings.Add.Port := 6000;
end;

procedure TForm13.IdTCPServer1Execute(AContext: TIdContext);
var
  LLine: String;
  Str, Hasta_ID: String;

begin

{AContext.Connection.IOHandler.DefStringEncoding:= IndyTextEncoding_UTF8;
SL := TStringList.Create;
LLine := AContext.Connection.IOHandler.ReadLn;
 try
    SL.Text := dbmemo1.Field.AsString;
    for LLine in SL do
    Memo1.Lines.Add(LLine);
  finally
    SL.Free;
  end;     }

  AContext.Connection.IOHandler.DefStringEncoding:= IndyTextEncoding_UTF8;
  LLine := AContext.Connection.IOHandler.ReadLn;
// LLine:= Memo1.Lines[1];
  Memo1.Lines.Add(LLine);

  AContext.Connection.IOHandler.WriteLn('OK');

 { Str := LLine;
  Hasta_ID := Parsing('|', Str, 3);
  //Hasta_ID := Parsing('|^', Str, 15);
  //Memo1.Lines.Add(Str);
  Memo1.Lines.Add(Hasta_ID);}

end;


procedure TForm13.ParseEt();
 var
  Str: String;
  Hasta_ID: String;
  LLine: String;
  Soyad: String;
  Ad: String;
  Dtarih: String;
  Cinsiyet: String;
  Epizot: String;
  Olay: String;
  Birim: String;
  x: String;
  y: String;
  z: String;
  MTipi: String;
  DozZ: String;
  Baslama: String;
  Bitis: String;
  Ýlaç_ID: String;
  Miktar: String;
  MiktarB: String;
  JAdý: String;
  TAdý: String;
  DozF: String;
  Güç: String;
  GüçB: String;
  Hacim: String;
  HacimB: String;
  Mtipi1: String;
  HacimS: String;

begin
Str := Memo1.Lines.Text;
Mtipi := Parsing1('|',Str,9);
Mtipi1 := Parsing('|',Str,9);
x:= 'ADT';
y:= 'RDE';
z:= 'MFN';
if  (Mtipi=x)  then  begin

  Olay := Parsing2('|',Str,3);
  Memo2.Lines.Add(Olay);
  Hasta_ID := Parsing('|', Str, 13);
  Memo2.Lines.Add(Hasta_ID);
  Soyad := Parsing1('|', Str, 15);
  Memo2.Lines.Add(Soyad);
  Ad := Parsing2('|', Str, 4);
  Memo2.Lines.Add(Ad);
  Dtarih := Parsing('|',Str,17);
  Memo2.Lines.Add(Dtarih);
  Cinsiyet := Parsing('|',Str,18);
  Memo2.Lines.Add(Cinsiyet);
  Birim := Parsing('|',Str,22);
  Memo2.Lines.Add(Birim);
  Epizot := Parsing('|',Str,38);
  Memo2.Lines.Add(Epizot);

  end else if (Mtipi=y) then begin

  Hasta_ID := Parsing('|', Str, 13);
  Memo2.Lines.Add(Hasta_ID);
  Epizot := Parsing('|', Str, 33);
  Memo2.Lines.Add(Epizot);
  Olay := Parsing('|', Str, 35);
  Memo2.Lines.Add(Olay);
  DozZ := Parsing('|',Str,42);
  Memo2.Lines.Add(DozZ);
  Baslama := Parsing('|',Str,43);
  Memo2.Lines.Add(Baslama);
  Bitis := Parsing('|',Str,44);
  Memo2.Lines.Add(Bitis);
  Ýlaç_ID := Parsing('|',Str,47);
  Memo2.Lines.Add(Ýlaç_ID);
  Miktar := Parsing('|',Str,48);
  Memo2.Lines.Add(Miktar);
  MiktarB := Parsing('|',Str,49);
  Memo2.Lines.Add(MiktarB);

  end else if (Mtipi1=z) then begin

  Olay := Parsing('|', Str, 11);
  Memo2.Lines.Add(Olay);
  HacimS := Parsing('|',Str,13);
  Memo2.Lines.Add(HacimS);
  Ýlaç_ID := Parsing('|',Str,14);
  Memo2.Lines.Add(Ýlaç_ID);
  JAdý := Parsing1('|', Str, 17);
  Memo2.Lines.Add(JAdý);
  TAdý := Parsing2('|', Str, 3);
  Memo2.Lines.Add(TAdý);
  DozF := Parsing('|',Str,19);
  Memo2.Lines.Add(DozF);
  Güç := Parsing1('|',Str,20);
  Memo2.Lines.Add(Güç);
  GüçB := Parsing2('|',Str,4);
  Memo2.Lines.Add(GüçB);
  Hacim := Parsing1('|',Str,21);
  Memo2.Lines.Add(Hacim);
  HacimB := Parsing2('|',Str,5);
  Memo2.Lines.Add(HacimB);
end;
end;

function TForm13.Parsing(Char, Str: string; Count: Integer): string;
var
  i: Integer;
  strResult: string;
begin

  if Str[Length(Str)] <> Char then
     Str := Str + Char;
  for i := 1 to Count do     //1 veya 2 gerisindekini almak için
  begin
     strResult := Copy(Str, 0, Pos(Char, Str) - 1);
     Str := Copy(Str, Pos(Char, Str) + 1, Length(Str));
  end;
  Result := strResult;
end;

function TForm13.Parsing1(Char, Str: string; Count: Integer): string;
var
  i: Integer;
  strResult: string;
begin

  if Str[Length(Str)] <> Char then
     Str := Str + Char;
  for i := 1 to Count do     //1 veya 2 gerisindekini almak için
  begin
     strResult := Copy(Str, 0, Pos('^', Str) - 1);
     Str := Copy(Str, Pos(Char, Str) + 1, Length(Str));
  end;
  Result := strResult;
end;

function TForm13.Parsing2(Char, Str: string; Count: Integer): string;
var
  i: Integer;
  strResult: string;
begin

  if Str[Length(Str)] <> Char then
     Str := Str + Char;
  for i := 1 to Count do     //1 veya 2 gerisindekini almak için
  begin
     strResult := Copy(Str, 0, Pos(Char, Str) - 1);
     Str := Copy(Str, Pos('^', Str) + 1, Length(Str));
  end;
  Result := strResult;
end;

end.
