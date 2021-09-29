unit uConsultaMusicas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Ani, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.JSON, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.ExtCtrls, Soap.EncdDecd, Vcl.Imaging.jpeg, Winapi.ShellAPI, fmx.Platform.Win, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  MMSystem, FMX.Media, Winapi.Windows, vcl.Controls;

type
  TfrmConsultaMusicas = class(TForm)
    Layout2: TLayout;
    imgSair: TImage;
    Layout3: TLayout;
    RoundRect1: TRoundRect;
    Line1: TLine;
    img_lupa: TImage;
    StyleBook1: TStyleBook;
    edtBuscarMusica: TEdit;
    restClient: TRESTClient;
    restRequest: TRESTRequest;
    restResponse: TRESTResponse;
    lvMusicas: TListView;
    img_play: TImage;
    img_pause: TImage;
    cpNota: TCalloutPanel;
    edtNota: TEdit;
    imgNota: TImage;
    lblNota: TLabel;
    img_close: TImage;
    procedure imgSairClick(Sender: TObject);
    procedure imgSairMouseEnter(Sender: TObject);
    procedure imgSairMouseLeave(Sender: TObject);
    procedure edtBuscarMusicaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure lvMusicasItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
     const ItemObject: TListItemDrawable);
    procedure edtNotaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgNotaClick(Sender: TObject);
    procedure img_closeClick(Sender: TObject);
  private
    procedure AdicionarMusicaListView(img_music, trackName, artistName, artistViewUrl, collectionViewUrl, trackViewUrl,
      wrapperType, kind, artistId, collectionId, collectionName, trackId, previewUrl: String; trackTimeMillis: LongInt);
    function MilisegundoEmMinutos(milisegundo: LongInt): string;
    function buscarCampo(pTipo, pTagItem: String): String;
    procedure gravaNotaMusical(pId, pNota: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaMusicas: TfrmConsultaMusicas;

const
  urlPadrao = 'https://itunes.apple.com/search?media=music&term=';

implementation

{$R *.fmx}

uses uDM_Modulo;

procedure TfrmConsultaMusicas.edtBuscarMusicaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  retornoJson: TJSONValue;
  jsArray: TJSONArray;
  i: Integer;
  fotoPlay: TStream;
begin
  try
    if (key = 13) then
    begin
      lvMusicas.Items.Clear;
      restClient.BaseURL := urlPadrao + Trim(edtBuscarMusica.Text);
      restRequest.Execute;

      if (restResponse.StatusCode <> 200) then
      begin
        ShowMessage('Erro ao realizar busca no servidor Itunes.');
        Exit;
      end;

      retornoJson := TJSONObject.ParseJSONValue(restResponse.Content) as TJSONObject;
      if(retornoJson <> nil)then
      begin
        jsArray := retornoJson.GetValue<TJSONArray>('results') as TJSONArray;
        for i := 0 to jsArray .Count-1 do
        begin
          retornoJson := jsArray.Items[i] as TJSONObject;
          //AdicionarMusicaListView(String(EncodeBase64(AnsiString(retornoJson.GetValue<string>('artworkUrl60')))),
          AdicionarMusicaListView(retornoJson.GetValue<string>('artworkUrl60'),
                                  retornoJson.GetValue<string>('trackName'),
                                  retornoJson.GetValue<string>('artistName'),
                                  retornoJson.GetValue<string>('artistViewUrl'),
                                  retornoJson.GetValue<string>('collectionViewUrl'),
                                  retornoJson.GetValue<String>('trackViewUrl'),
                                  retornoJson.GetValue<String>('wrapperType'),
                                  retornoJson.GetValue<String>('kind'),
                                  retornoJson.GetValue<String>('artistId'),
                                  retornoJson.GetValue<String>('collectionId'),
                                  retornoJson.GetValue<String>('collectionName'),
                                  retornoJson.GetValue<String>('trackId'),
                                  retornoJson.GetValue<String>('previewUrl'),
                                  retornoJson.GetValue<LongInt>('trackTimeMillis'));
        end;
      end;
   end;
  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.edtBuscarMusicaKeyDown' + #13 + E.Message);
    end;
  end;
end;

procedure TfrmConsultaMusicas.edtNotaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (not (KeyChar in ['0'..'9', ','])) and (ord(keychar) <> 8) and (KeyChar <> #0) then
  begin
    KeyChar := #0;
  end;
end;

procedure TfrmConsultaMusicas.AdicionarMusicaListView(img_music, trackName, artistName, artistViewUrl, collectionViewUrl, trackViewUrl,
  wrapperType, kind, artistId, collectionId, collectionName, trackId, previewUrl: String; trackTimeMillis: LongInt);
var
  imgMusic: TListItemImage;
  bmp: TBitmap;
  vNota: String;
begin
  try
    with lvMusicas.Items.Add do
    begin
      TagString := trackId;
      {inserir registros}
      with dm_Modulo.qryGeral do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select *');
        SQL.Add('  from jsonItunesAPI');
        SQL.Add(' where trackId = :trackId');
        ParamByName('trackId').AsString := trackId;
        Open;

        if (dm_Modulo.qryGeral.IsEmpty) then
        begin
          dm_Modulo.fdTransaction.StartTransaction;
          try
            Close;
            SQL.Clear;
            SQL.Add('insert into jsonItunesAPI');
            SQL.Add('       (trackName, artistName, artistViewUrl, collectionViewUrl, trackViewUrl, wrapperType, kind, trackTimeMillis, artistId, collectionId, collectionName, trackId, previewUrl)');
            SQL.Add(' values (:trackName, :artistName, :artistViewUrl, :collectionViewUrl, :trackViewUrl, :wrapperType, :kind, :trackTimeMillis, :artistId, :collectionId, :collectionName, :trackId, :previewUrl)');
            ParamByName('trackName').AsString := trackName;
            ParamByName('artistName').AsString := artistName;
            ParamByName('artistViewUrl').AsString := artistViewUrl;
            ParamByName('collectionViewUrl').AsString := collectionViewUrl;
            ParamByName('trackViewUrl').AsString := trackViewUrl;
            ParamByName('wrapperType').AsString := wrapperType;
            ParamByName('kind').AsString := Kind;
            ParamByName('trackTimeMillis').AsInteger := trackTimeMillis;
            ParamByName('artistId').AsString := artistId;
            ParamByName('collectionId').AsString := collectionId;
            ParamByName('collectionName').AsString := collectionName;
            ParamByName('trackId').AsString := trackId;
            ParamByName('previewUrl').AsString := previewUrl;
            ExecSQL;

          except
            dm_Modulo.fdTransaction.Rollback;
          end;
        end;
      end;

      {carregar listview}
      //TListItemImage(Objects.FindDrawable('img_music')).Bitmap := img_music;

      TListItemText(Objects.FindDrawable('txtArtistaURL')).Text := 'Artista';
      TListItemText(Objects.FindDrawable('txtColletionURL')).Text := 'Colletion';
      TListItemText(Objects.FindDrawable('txtTrackURL')).Text := 'Track';

      TListItemText(Objects.FindDrawable('txtMusicName')).Text := trackName;
      TListItemText(Objects.FindDrawable('txtArtistName')).Text := artistName;
      TListItemText(Objects.FindDrawable('txtDuracaoMusic')).Text := MilisegundoEmMinutos(trackTimeMillis);

      vNota := buscarCampo('notaMusical', trackId);
      if (vNota = EmptyStr) then
      begin
        TListItemText(Objects.FindDrawable('txtNotaMusica')).Text := 'Nota';
      end
      else
      begin
        TListItemText(Objects.FindDrawable('txtNotaMusica')).Text := FormatFloat('#,#0.0' , StrToFloat(vNota));
      end;
    end;
  except
    on E: Exception do
    begin
      dm_Modulo.fdTransaction.Rollback;
      ShowMessage('TfrmConsultaMusicas.AdicionarMusicaListView' + #13 + E.Message);
    end;
  end;
end;

procedure TfrmConsultaMusicas.imgNotaClick(Sender: TObject);
begin
  if (Trim(edtNota.Text) = EmptyStr) then
  begin
    ShowMessage('Digite uma nota de 1 a 10.');
    edtNota.SetFocus;
    Exit;
  end;
  if (StrToFloat(edtNota.Text) > 10) then
  begin
    ShowMessage('Permitido escolher uma nota de 1 a 10.');
    edtNota.SetFocus;
    Exit;
  end;

  gravaNotaMusical(lvMusicas.Selected.TagString, edtNota.Text);
  cpNota.Visible := False;
  lvMusicas.Enabled := not cpNota.Visible;
end;

procedure TfrmConsultaMusicas.imgSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaMusicas.imgSairMouseEnter(Sender: TObject);
begin
  try
    (Sender as TImage).Width  := (Sender as TImage).Width + 20;
    (Sender as TImage).Height := (Sender as TImage).Height + 20;
  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.imgSairMouseEnter' + #13 + E.Message);
    end;
  end;
end;

procedure TfrmConsultaMusicas.imgSairMouseLeave(Sender: TObject);
begin
  try
    (Sender as TImage).Width  := (Sender as TImage).Width - 20;
    (Sender as TImage).Height := (Sender as TImage).Height - 20;
  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.imgSairMouseLeave' + #13 + E.Message);
    end;
  end;
end;

procedure TfrmConsultaMusicas.img_closeClick(Sender: TObject);
begin
  try
    edtBuscarMusica.Text := EmptyStr;
    edtBuscarMusica.SetFocus;
  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.img_closeClick' + #13 + E.Message);
    end;
  end;
end;

procedure TfrmConsultaMusicas.lvMusicasItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  AItem: String;
  mpPlayer: TMediaPlayer;
  imgMusic: TListItemImage;
  bmp: TBitmap;
  fotoPause: TStream;
  pT: TPoint;
begin
  try
    if TListView(Sender).Selected <> nil then
    begin
      AItem := lvMusicas.Selected.TagString;
      if (TListItemText(ItemObject).Name = 'txtArtistaURL') then
      begin
        ShellExecute(FmxHandleToHWND(Handle), 'open', PChar(buscarCampo('artistViewUrl', AItem)), '', '', 1);
      end;

      if (TListItemText(ItemObject).Name = 'txtColletionURL') then
      begin
        ShellExecute(FmxHandleToHWND(Handle), 'open', PChar(buscarCampo('collectionViewUrl', AItem)), '', '', 1);
      end;

      if (TListItemText(ItemObject).Name = 'txtTrackURL') then
      begin
        ShellExecute(FmxHandleToHWND(Handle), 'open', PChar(buscarCampo('trackViewUrl', AItem)), '', '', 1);
      end;

      if (TListItemText(ItemObject).Name = 'txtNotaMusica') then
      begin
        cpNota.Visible := True;
        lvMusicas.Enabled := not cpNota.Visible;
        edtNota.SetFocus;
        edtNota.Text := buscarCampo('notaMusical', AItem);
      end;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.lvMusicasItemClickEx' + #13 + E.Message);
    end;
  end;
end;

function TfrmConsultaMusicas.buscarCampo(pTipo, pTagItem: String): String;
begin
  Result := EmptyStr;
  try
    dm_Modulo.qryGeral2.Open;
    with dm_Modulo.qryGeral2 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select *');
      SQL.Add('  from jsonItunesAPI');
      SQL.Add(' where trackId = :trackId');
      ParamByName('trackId').AsString := pTagItem;
      Open;

      Result := dm_Modulo.qryGeral2.FieldByName(pTipo).AsString;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.buscarCampo' + #13 + E.Message);
    end
  end;
end;

procedure TfrmConsultaMusicas.gravaNotaMusical(pId, pNota: String);
var
  key: word;
  key2: char;
  Shift: TShiftState;
begin
  try
    with dm_Modulo.qryGeral do
    begin
      dm_Modulo.fdTransaction.StartTransaction;
      try
        Close;
        SQL.Clear;
        SQL.Add('update jsonItunesAPI');
        SQL.Add('   set notaMusical = :notaMusical');
        SQL.Add(' where trackId = :trackId');
        ParamByName('trackId').AsString := pId;
        ParamByName('notaMusical').AsFloat := StrToFloat(pNota);
        ExecSQL;

        key := VK_RETURN;
        if (RowsAffected > 0) then
        begin
          edtBuscarMusicaKeyDown(edtBuscarMusica, key, key2, Shift);
        end;
      except
        dm_Modulo.fdTransaction.Rollback;
      end;
    end;
  except
    on E: Exception do
    begin
      dm_Modulo.fdTransaction.Rollback;
      ShowMessage('TfrmConsultaMusicas.gravaNotaMusical' + #13 + E.Message);
    end;
  end;
end;

function TfrmConsultaMusicas.MilisegundoEmMinutos(milisegundo: LongInt): string;
var
  vHora, vMinuto, vSegundo, vMsegundo: word;
begin
  try
    vHora := milisegundo div 3600000;
    milisegundo := milisegundo mod 3600000;

    vMinuto:= milisegundo div 60000;
    milisegundo := milisegundo mod 60000;

    vSegundo := milisegundo div 1000;

    Result := FormatDateTime('hh:mm:ss', EncodeTime(vHora, vMinuto, vSegundo, 0)); //Format('%d:%d', [vMinuto, vSegundo]);
  except
    on E: Exception do
    begin
      ShowMessage('TfrmConsultaMusicas.MilisegundoEmMinutos' + #13 + E.Message);
    end;
  end;
end;

end.
