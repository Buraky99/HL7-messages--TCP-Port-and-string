unit ClientHl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, DBAccess, Ora, IdBaseComponent,
  IdComponent, IdTCPConnection, OraCall, Vcl.StdCtrls ,IdGlobal,
  MemDS,IdTCPClient;

type
  TForm12 = class(TForm)
    OraSession1: TOraSession;
    IdTCPClient1: TIdTCPClient;
    CheckBoxConnectDisconnet: TCheckBox;
    Button1: TButton;
    procedure CheckBoxConnectDisconnetClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
  procedure HastaKabul(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Epizot_No: Integer);
  procedure HastaTransfer(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Yat��_B�l�m�: String;Epizot_No: Integer);
  procedure HastaTaburcu(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Yat��_B�l�m�: String;Epizot_No: Integer);
  procedure YeniOrder(Hasta_ID: Integer;Epizot_No: Integer;Doz_Zaman�: Integer;Ba�lang��_Tarihi: Integer;Biti�_Tarihi: Integer;�la�_ID: Integer;Verilecek_Miktar: Integer;Miktar_Birimi: String);
  procedure �ptalEt(Hasta_ID: Integer;Epizot_No: Integer;Doz_Zaman�: Integer;Ba�lang��_Tarihi: Integer;Biti�_Tarihi: Integer;�la�_ID: Integer;Verilecek_Miktar: Integer;Miktar_Birimi: String);
  procedure �la�Ekleme(Hacim: Integer;�la�_ID: Integer;Jenerik_Ad�: String;Marka_Ad�: String;Doz_Formu: String;G��: Integer;G��_Birimi: String;HacimS: Integer;Hacim_Birimi: String);
  procedure �la�G�ncelleme(Hacim: Integer;�la�_ID: Integer;Jenerik_Ad�: String;Marka_Ad�: String;Doz_Formu: String;G��: Integer;G��_Birimi: String; HacimS: Integer;Hacim_Birimi: String);
  procedure �la�Silme(Hacim: Integer;�la�_ID: Integer;Jenerik_Ad�: String;Marka_Ad�: String;Doz_Formu: String;G��: Integer;G��_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
  procedure Pasife�ekme(Hacim: Integer;�la�_ID: Integer;Jenerik_Ad�: String;Marka_Ad�: String;Doz_Formu: String;G��: Integer;G��_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
  procedure AktifEtme(Hacim: Integer;�la�_ID: Integer;Jenerik_Ad�: String;Marka_Ad�: String;Doz_Formu: String;G��: Integer;G��_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
   { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.AktifEtme(Hacim, �la�_ID: Integer; Jenerik_Ad�, Marka_Ad�,
  Doz_Formu: String; G��: Integer; G��_Birimi: String; HacimS: Integer; Hacim_Birimi: String);

var msh: String;
var mfe: String;
var zfy: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|StockArt|Bossan Hospital|20180711155423||MFN| ';

 //mfe
mfe := 'MFE|MAC| ';

 //zfy
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(�la�_ID)+'|||'+Jenerik_Ad�+'^'+Marka_Ad�+'||'+Doz_Formu+'|'+IntToStr(G��)+'^'+G��_Birimi+'|'+IntToStr(HacimS)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.Button1Click(Sender: TObject);
begin
//HastaKabul(3,'soyad','ad',2,'cinsiyet',3);
//HastaTransfer(4,'soyad�','ad�',05041999,'erkek','OR',4);
//HastaTaburcu(5,'soyad�','ad�',06062000,'k�z','OR',5);
//YeniOrder(6,6,1440,19102021,22102021,666,1,'Ampul');
//�ptalEt(6,6,1440,19102021,22102021,666,1,'Ampul');
�la�Ekleme(7,777,'jenerik','marka','ampul',7,'mg',7,'ml');
//�la�G�ncelleme(8,888,'jenerik','marka','ampul',8,'mg',8,'ml');
{�la�Silme(9,999,'jenerik','marka','ampul',9,'mg',9,'ml');
Pasife�ekme(10,101010,'jenerik','marka','ampul',10,'mg',10,'ml');
AktifEtme(11,111111,'jenerik','marka','ampul',11,'mg',11,'ml');}
end;

procedure TForm12.CheckBoxConnectDisconnetClick(Sender: TObject);
begin
  if ( CheckBoxConnectDisconnet.Checked = True ) then
  begin
    IdTCPClient1.Host := '127.0.0.1';
    IdTCPClient1.Port := 6000;
    IdTCPClient1.Connect;

  end
  else
    IdTCPClient1.Disconnect;
end;

procedure TForm12.HastaKabul(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Epizot_No: Integer);

var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A01|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyad�+'^'+Hasta_Ad�+'||'+IntToStr(Hasta_Do�um_Tarihi)+'|'+Hasta_Cinsiyeti+'|';

 //pvi
pvi := 'PV1|||ICU||||||||||||||||'+IntToStr(Epizot_No)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+''+#13#10+''+pid+''+#13#10+''+pvi+''+#13#10+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
end;

procedure TForm12.HastaTaburcu(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Yat��_B�l�m�: String;Epizot_No: Integer);

 var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

//msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A03|';


 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyad�+'^'+Hasta_Ad�+'||'+IntToStr(Hasta_Do�um_Tarihi)+'|'+Hasta_Cinsiyeti+'|';
 //pvi

pvi := 'PV1|||'+Yat��_B�l�m�+'||||||||||||||||'+IntToStr(Epizot_No)+'|';


IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;


procedure TForm12.HastaTransfer(Hasta_ID: Integer;Hasta_Soyad�: String;Hasta_Ad�: String;Hasta_Do�um_Tarihi: Integer;Hasta_Cinsiyeti: String;Yat��_B�l�m�: String;Epizot_No: Integer);

var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A03|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyad�+'^'+Hasta_Ad�+'||'+IntToStr(Hasta_Do�um_Tarihi)+'|'+Hasta_Cinsiyeti+'|';

 //pvi
pvi := 'PV1|||'+Yat��_B�l�m�+'||||||||||||||||'+IntToStr(Epizot_No)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.Pasife�ekme(Hacim, �la�_ID: Integer; Jenerik_Ad�,
  Marka_Ad�, Doz_Formu: String; G��: Integer; G��_Birimi: String; HacimS: Integer;
  Hacim_Birimi: String);

var msh: String;
var mfe: String;
var zfy: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|StockArt|Bossan Hospital|20180711155423||MFN| ';

 //mfe
mfe := 'MFE|MDC| ';

 //zfy
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(�la�_ID)+'|||'+Jenerik_Ad�+'^'+Marka_Ad�+'||'+Doz_Formu+'|'+IntToStr(G��)+'^'+G��_Birimi+'|'+IntToStr(HacimS)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.YeniOrder(Hasta_ID, Epizot_No, Doz_Zaman�,
  Ba�lang��_Tarihi, Biti�_Tarihi, �la�_ID, Verilecek_Miktar: Integer;
  Miktar_Birimi: String);

var msh: String;
var pid: String;
var pvi: String;
var orc: String;
var tq1: String;
var rxe: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||RDE^011|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'|';

 //pvi
pvi := 'PV1|||||||||||||||||||'+IntToStr(Epizot_No)+'|';

 //orc
orc := 'ORC|NW||900|'   ;

 //tq1
tq1 := 'TQ1|||Q12H|'+IntToStr(Doz_Zaman�)+'|'+IntToStr(Ba�lang��_Tarihi)+'|'+IntToStr(Biti�_Tarihi)+'|';

 //rxe
rxe := 'RXE||'+IntToStr(�la�_ID)+'|'+IntToStr(Verilecek_Miktar)+'|'+(Miktar_Birimi)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+orc+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+tq1+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+rxe+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.�la�Ekleme(Hacim, �la�_ID: Integer; Jenerik_Ad�,
  Marka_Ad�, Doz_Formu: String; G��: Integer; G��_Birimi: String;HacimS: Integer;
  Hacim_Birimi: String);
var msh: String;
var mfe: String;
var zfy: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|StockArt|Bossan Hospital|20180711155423||MFN| ';

 //mfe
mfe := 'MFE|MAD| ';

 //zfy
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(�la�_ID)+'|||'+Jenerik_Ad�+'^'+Marka_Ad�+'||'+Doz_Formu+'|'+IntToStr(G��)+'^'+G��_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.�la�G�ncelleme(Hacim, �la�_ID: Integer; Jenerik_Ad�,
  Marka_Ad�, Doz_Formu: String; G��: Integer; G��_Birimi: String; HacimS: Integer;
  Hacim_Birimi: String);

var msh: String;
var mfe: String;
var zfy: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|StockArt|Bossan Hospital|20180711155423||MFN| ';

 //mfe
mfe := 'MFE|MUP| ';

 //zfy
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(�la�_ID)+'|||'+Jenerik_Ad�+'^'+Marka_Ad�+'||'+Doz_Formu+'|'+IntToStr(G��)+'^'+G��_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.�la�Silme(Hacim, �la�_ID: Integer; Jenerik_Ad�,
  Marka_Ad�, Doz_Formu: String; G��: Integer; G��_Birimi: String; HacimS: Integer;
  Hacim_Birimi: String);

var msh: String;
var mfe: String;
var zfy: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|StockArt|Bossan Hospital|20180711155423||MFN| ';

 //mfe
mfe := 'MFE|MDL| ';

 //zfy
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(�la�_ID)+'|||'+Jenerik_Ad�+'^'+Marka_Ad�+'||'+Doz_Formu+'|'+IntToStr(G��)+'^'+G��_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.�ptalEt(Hasta_ID, Epizot_No, Doz_Zaman�,
  Ba�lang��_Tarihi, Biti�_Tarihi, �la�_ID, Verilecek_Miktar: Integer;
  Miktar_Birimi: String);
var msh: String;
var pid: String;
var pvi: String;
var orc: String;
var tq1: String;
var rxe: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||RDE^011|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'|';

 //pvi
pvi := 'PV1|||||||||||||||||||'+IntToStr(Epizot_No)+'|';

 //orc
orc := 'ORC|CA||900|'   ;

 //tq1
tq1 := 'TQ1|||Q12H|'+IntToStr(Doz_Zaman�)+'|'+IntToStr(Ba�lang��_Tarihi)+'|'+IntToStr(Biti�_Tarihi)+'|';

 //rxe
rxe := 'RXE||'+IntToStr(�la�_ID)+'|'+IntToStr(Verilecek_Miktar)+'|'+(Miktar_Birimi)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+orc+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+tq1+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+rxe+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

end.
