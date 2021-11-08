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
  procedure HastaKabul(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Epizot_No: Integer);
  procedure HastaTransfer(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Yatýþ_Bölümü: String;Epizot_No: Integer);
  procedure HastaTaburcu(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Yatýþ_Bölümü: String;Epizot_No: Integer);
  procedure YeniOrder(Hasta_ID: Integer;Epizot_No: Integer;Doz_Zamaný: Integer;Baþlangýç_Tarihi: Integer;Bitiþ_Tarihi: Integer;Ýlaç_ID: Integer;Verilecek_Miktar: Integer;Miktar_Birimi: String);
  procedure ÝptalEt(Hasta_ID: Integer;Epizot_No: Integer;Doz_Zamaný: Integer;Baþlangýç_Tarihi: Integer;Bitiþ_Tarihi: Integer;Ýlaç_ID: Integer;Verilecek_Miktar: Integer;Miktar_Birimi: String);
  procedure ÝlaçEkleme(Hacim: Integer;Ýlaç_ID: Integer;Jenerik_Adý: String;Marka_Adý: String;Doz_Formu: String;Güç: Integer;Güç_Birimi: String;HacimS: Integer;Hacim_Birimi: String);
  procedure ÝlaçGüncelleme(Hacim: Integer;Ýlaç_ID: Integer;Jenerik_Adý: String;Marka_Adý: String;Doz_Formu: String;Güç: Integer;Güç_Birimi: String; HacimS: Integer;Hacim_Birimi: String);
  procedure ÝlaçSilme(Hacim: Integer;Ýlaç_ID: Integer;Jenerik_Adý: String;Marka_Adý: String;Doz_Formu: String;Güç: Integer;Güç_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
  procedure PasifeÇekme(Hacim: Integer;Ýlaç_ID: Integer;Jenerik_Adý: String;Marka_Adý: String;Doz_Formu: String;Güç: Integer;Güç_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
  procedure AktifEtme(Hacim: Integer;Ýlaç_ID: Integer;Jenerik_Adý: String;Marka_Adý: String;Doz_Formu: String;Güç: Integer;Güç_Birimi: String; HacimS: Integer; Hacim_Birimi: String);
   { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.AktifEtme(Hacim, Ýlaç_ID: Integer; Jenerik_Adý, Marka_Adý,
  Doz_Formu: String; Güç: Integer; Güç_Birimi: String; HacimS: Integer; Hacim_Birimi: String);

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
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(Ýlaç_ID)+'|||'+Jenerik_Adý+'^'+Marka_Adý+'||'+Doz_Formu+'|'+IntToStr(Güç)+'^'+Güç_Birimi+'|'+IntToStr(HacimS)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.Button1Click(Sender: TObject);
begin
//HastaKabul(3,'soyad','ad',2,'cinsiyet',3);
//HastaTransfer(4,'soyadý','adý',05041999,'erkek','OR',4);
//HastaTaburcu(5,'soyadý','adý',06062000,'kýz','OR',5);
//YeniOrder(6,6,1440,19102021,22102021,666,1,'Ampul');
//ÝptalEt(6,6,1440,19102021,22102021,666,1,'Ampul');
ÝlaçEkleme(7,777,'jenerik','marka','ampul',7,'mg',7,'ml');
//ÝlaçGüncelleme(8,888,'jenerik','marka','ampul',8,'mg',8,'ml');
{ÝlaçSilme(9,999,'jenerik','marka','ampul',9,'mg',9,'ml');
PasifeÇekme(10,101010,'jenerik','marka','ampul',10,'mg',10,'ml');
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

procedure TForm12.HastaKabul(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Epizot_No: Integer);

var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A01|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyadý+'^'+Hasta_Adý+'||'+IntToStr(Hasta_Doðum_Tarihi)+'|'+Hasta_Cinsiyeti+'|';

 //pvi
pvi := 'PV1|||ICU||||||||||||||||'+IntToStr(Epizot_No)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+''+#13#10+''+pid+''+#13#10+''+pvi+''+#13#10+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
end;

procedure TForm12.HastaTaburcu(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Yatýþ_Bölümü: String;Epizot_No: Integer);

 var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

//msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A03|';


 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyadý+'^'+Hasta_Adý+'||'+IntToStr(Hasta_Doðum_Tarihi)+'|'+Hasta_Cinsiyeti+'|';
 //pvi

pvi := 'PV1|||'+Yatýþ_Bölümü+'||||||||||||||||'+IntToStr(Epizot_No)+'|';


IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;


procedure TForm12.HastaTransfer(Hasta_ID: Integer;Hasta_Soyadý: String;Hasta_Adý: String;Hasta_Doðum_Tarihi: Integer;Hasta_Cinsiyeti: String;Yatýþ_Bölümü: String;Epizot_No: Integer);

var msh: String;
var pid: String;
var pvi: String;
var pvino: String;
var Lline: String;

begin

 //msh
msh := 'MSH|^~\&|MedData|Bossan Hospital|Stockart|Bossan Hospital|||ADT^A03|';

 //pid
pid := 'PID|||'+IntToStr(Hasta_ID)+'||'+Hasta_Soyadý+'^'+Hasta_Adý+'||'+IntToStr(Hasta_Doðum_Tarihi)+'|'+Hasta_Cinsiyeti+'|';

 //pvi
pvi := 'PV1|||'+Yatýþ_Bölümü+'||||||||||||||||'+IntToStr(Epizot_No)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.PasifeÇekme(Hacim, Ýlaç_ID: Integer; Jenerik_Adý,
  Marka_Adý, Doz_Formu: String; Güç: Integer; Güç_Birimi: String; HacimS: Integer;
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
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(Ýlaç_ID)+'|||'+Jenerik_Adý+'^'+Marka_Adý+'||'+Doz_Formu+'|'+IntToStr(Güç)+'^'+Güç_Birimi+'|'+IntToStr(HacimS)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.YeniOrder(Hasta_ID, Epizot_No, Doz_Zamaný,
  Baþlangýç_Tarihi, Bitiþ_Tarihi, Ýlaç_ID, Verilecek_Miktar: Integer;
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
tq1 := 'TQ1|||Q12H|'+IntToStr(Doz_Zamaný)+'|'+IntToStr(Baþlangýç_Tarihi)+'|'+IntToStr(Bitiþ_Tarihi)+'|';

 //rxe
rxe := 'RXE||'+IntToStr(Ýlaç_ID)+'|'+IntToStr(Verilecek_Miktar)+'|'+(Miktar_Birimi)+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pid+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+pvi+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+orc+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+tq1+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+rxe+'',IndyTextEncoding_UTF8);

IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.ÝlaçEkleme(Hacim, Ýlaç_ID: Integer; Jenerik_Adý,
  Marka_Adý, Doz_Formu: String; Güç: Integer; Güç_Birimi: String;HacimS: Integer;
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
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(Ýlaç_ID)+'|||'+Jenerik_Adý+'^'+Marka_Adý+'||'+Doz_Formu+'|'+IntToStr(Güç)+'^'+Güç_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);

end;

procedure TForm12.ÝlaçGüncelleme(Hacim, Ýlaç_ID: Integer; Jenerik_Adý,
  Marka_Adý, Doz_Formu: String; Güç: Integer; Güç_Birimi: String; HacimS: Integer;
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
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(Ýlaç_ID)+'|||'+Jenerik_Adý+'^'+Marka_Adý+'||'+Doz_Formu+'|'+IntToStr(Güç)+'^'+Güç_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.ÝlaçSilme(Hacim, Ýlaç_ID: Integer; Jenerik_Adý,
  Marka_Adý, Doz_Formu: String; Güç: Integer; Güç_Birimi: String; HacimS: Integer;
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
zfy := 'ZFY|'+IntToStr(Hacim)+'|'+IntToStr(Ýlaç_ID)+'|||'+Jenerik_Adý+'^'+Marka_Adý+'||'+Doz_Formu+'|'+IntToStr(Güç)+'^'+Güç_Birimi+'|'+IntToStr(Hacim)+'^'+Hacim_Birimi+'|';

IdTCPClient1.IOHandler.WriteLn(''+msh+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+mfe+'',IndyTextEncoding_UTF8);
IdTCPClient1.IOHandler.WriteLn(''+zfy+'',IndyTextEncoding_UTF8);


IdTCPClient1.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
Lline := IdTCPClient1.IOHandler.ReadLn(#10,IndyTextEncoding_UTF8);
end;

procedure TForm12.ÝptalEt(Hasta_ID, Epizot_No, Doz_Zamaný,
  Baþlangýç_Tarihi, Bitiþ_Tarihi, Ýlaç_ID, Verilecek_Miktar: Integer;
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
tq1 := 'TQ1|||Q12H|'+IntToStr(Doz_Zamaný)+'|'+IntToStr(Baþlangýç_Tarihi)+'|'+IntToStr(Bitiþ_Tarihi)+'|';

 //rxe
rxe := 'RXE||'+IntToStr(Ýlaç_ID)+'|'+IntToStr(Verilecek_Miktar)+'|'+(Miktar_Birimi)+'|';

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
