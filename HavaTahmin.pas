unit HavaTahmin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts, FMX.ExtCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  System.JSON, System.Sensors, System.Sensors.Components, System.Math,
  StrUtils, FMX.Header, FMX.Platform, FMX.Objects;

type
  TForm2 = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    GridPanelLayout2: TGridPanelLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    TahminSaat1: TLabel;
    TahminDerece1: TLabel;
    TahminAciklama1: TLabel;
    TahminSaat2: TLabel;
    TahminDerece2: TLabel;
    TahminAciklama2: TLabel;
    TahminSaat3: TLabel;
    TahminDerece3: TLabel;
    TahminAciklama3: TLabel;
    TahminDerece4: TLabel;
    TahminAciklama4: TLabel;
    TahminSaat4: TLabel;
    TahminSaat5: TLabel;
    TahminAciklama5: TLabel;
    TahminDerece5: TLabel;
    GridPanelLayout3: TGridPanelLayout;
    SpeedButton1: TSpeedButton;
    Image6: TImage;
    TahminSaat6: TLabel;
    TahminDerece6: TLabel;
    TahminAciklama6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

uses
  System.IOUtils,
  System.Generics.Collections,
  AnaEkran;

procedure TForm2.FormShow(Sender: TObject);
var
  JSONString, saat, ic: string;
  HavaDurumuData2, TahminVeri: TJSONObject;
  SaatlikTahmin: TJSONArray;
  tahminSicaklik: Double;
  I: Integer;
begin
  if (Form1.URL2 <> 'NAN') then
  begin
    JSONString := THttpClient.Create.Get(Form1.URL2).ContentAsString;
    HavaDurumuData2 := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
    SaatlikTahmin:=HavaDurumuData2.GetValue('list') as TJSONArray;

    // ilk 6 hava tahmini degerinin alinmasi
    for I := 0 to 5 do
    begin
      TahminVeri := SaatlikTahmin.Items[I] as TJSONObject;
      saat:= LeftStr(RightStr(TahminVeri.GetValue<string>('dt_txt'),8),5);

      // tahminin ait oldugu saate gore gece/gunduz ikonlarinin secilmesi
      if (StrToTime(saat) > StrToTime('06:00')) and (StrToTime(saat) < StrToTime('20:00')) then
        ic := 'd' else ic := 'n';

      tahminSicaklik := TahminVeri.GetValue('main').GetValue<Double>('temp');

      var id := (TahminVeri.GetValue('weather') as TJSONArray).Items[0].GetValue<integer>('id');

      case I of
        0:
        begin
          Image1.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat1.Text := saat;

          if (Form1.CelFahr = True) then  // true ise celcius
            TahminDerece1.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece1.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama1.Text := aciklamaCek(id);
        end;

        1:
        begin
          Image2.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat2.Text := saat;

          if (Form1.CelFahr = True) then
            TahminDerece2.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece2.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama2.Text := aciklamaCek(id);
        end;

        2:
        begin
          Image3.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat3.Text := saat;

          if (Form1.CelFahr = True) then
            TahminDerece3.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece3.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama3.Text := aciklamaCek(id);
        end;

        3:
        begin
          Image4.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat4.Text := saat;

          if (Form1.CelFahr = True) then
            TahminDerece4.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece4.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama4.Text := AciklamaCek(id);
        end;

        4:
        begin
          Image5.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat5.Text := saat;

          if (Form1.CelFahr = True) then
            TahminDerece5.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece5.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama5.Text := aciklamaCek(id);
        end;

        5:
        begin
          Image6.Bitmap.LoadFromFile(TPath.GetDocumentsPath	+ PathDelim + 'owmikon/' + ikonCek(id) + ic + '.png');
          TahminSaat6.Text := saat;

          if (Form1.CelFahr = True) then
            TahminDerece6.Text := FormatFloat('#.#', tahminSicaklik - 273.15) + ' °C'
          else
            TahminDerece6.Text := FormatFloat('#.#', tahminSicaklik) + ' °F';

          TahminAciklama6.Text := aciklamaCek(id);
        end;
      end;
    end;
  end;
  GridPanelLayout1.Visible := True;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  Form1.Timer1.Enabled := True;
  GridPanelLayout1.Visible := False;
  Form2.Hide;
end;

end.
