unit uCadVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pCadComum, DB, cTela, JvComponentBase, JvBalloonHint, ComCtrls,
  StdCtrls, Buttons, sBitBtn, ExtCtrls, sPanel, sSkinProvider, Mask, DBCtrls,
  Menus, Grids, DBGrids, JvExDBGrids, JvDBGrid, sLabel, cFuncaoAuto, FMTBcd,
  sSpeedButton, JvExMask, JvToolEdit, JvBaseEdits, JvDBControls,
  uFraVendaProduto, cVenda, uFraPagamento;

type
  TCadVenda = class(TCadComum)
    TbShtVenda: TTabSheet;
    sSkinProvider: TsSkinProvider;
    Label6: TLabel;
    DBEdtVendedor: TDBEdit;
    dbEdtLkpNomeVendedor: TDBEdit;
    sBtBtnBuscaVendedor: TsBitBtn;
    sBtBtnCadVendedor: TsBitBtn;
    Label1: TLabel;
    dbEdtCliente: TDBEdit;
    dbEdtlkpNomeCliente: TDBEdit;
    sBtBtnPesquisaCliente: TsBitBtn;
    sBtBtnCadCliente: TsBitBtn;
    TBShetFechaVenda: TTabSheet;
    FraVendaProduto: TFraVendaProduto;
    FraPagamento: TFraPagamento;
    procedure FormCreate(Sender: TObject);
    procedure sBtBtnSalvarClick(Sender: TObject);
    procedure sSkinProviderTitleButtons0MouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sBtBtnCancelarClick(Sender: TObject);
    procedure sBtBtnBuscaVendedorClick(Sender: TObject);
    procedure sBtBtnPesquisaClienteClick(Sender: TObject);
    procedure sBtBtnCadVendedorClick(Sender: TObject);
    procedure sBtBtnCadClienteClick(Sender: TObject);
    procedure dbEdtClienteExit(Sender: TObject);
    procedure DBEdtVendedorExit(Sender: TObject);
    procedure dbEdtlkpNomeClienteEnter(Sender: TObject);
    procedure dbEdtLkpNomeVendedorEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FTotalVendido: double;
    procedure FecharVenda;
    function GetDesconto: double;
    procedure SubTotalizaCupom(dblDesconto:double);
    { Private declarations }
  published
    { Public declarations }
  end;

var
  CadVenda: TCadVenda;

implementation

uses uDtMdlMovVenda, cFuncaoString, uDtMdlConexao, uDtMdlGeral, uFrmMenuPrincipal,
  uDtMdlConfig, uDtMdlCadCliente, uCadCliente, uCadUsuario, uDtMdlCadProduto,
  cMensagem, uCadProduto;

{$R *.dfm}

procedure TCadVenda.dbEdtClienteExit(Sender: TObject);
var
  intCodigo: integer;
begin
  inherited;
  intCodigo := StrToIntDef(ControlaBD.GetValorCampoStr('IDCLIENTE'),0);
  if not ControlaBD.isRegistroExistente('IDCLIENTE','CLIENTE',intCodigo) then
  begin
    if intCodigo <> 0 then
      Mensagem('Cliente não encontrado. Tente novamente');
    ControlaBD.SetValorCampo('IDCLIENTE',null);
    dbEdtlkpNomeCliente.SetFocus;
  end;
end;

procedure TCadVenda.dbEdtlkpNomeClienteEnter(Sender: TObject);
begin
  inherited;
  sBtBtnPesquisaCliente.SetFocus;
end;

procedure TCadVenda.dbEdtLkpNomeVendedorEnter(Sender: TObject);
begin
  inherited;
  sBtBtnBuscaVendedor.SetFocus;
end;

procedure TCadVenda.DBEdtVendedorExit(Sender: TObject);
var
  intCodigo: integer;
begin
  inherited;
  intCodigo := StrToIntDef(ControlaBD.GetValorCampoStr('IDVENDEDOR'),0);
  if not ControlaBD.isRegistroExistente('IDUSUARIO','CONFIG_USUARIO',intCodigo) then
  begin
    if intCodigo <> 0 then
      Mensagem('Vendedor não encontrado. Tente novamente');
    ControlaBD.SetValorCampo('IDVENDEDOR',null);
    dbEdtLkpNomeVendedor.SetFocus;
  end;
end;

procedure TCadVenda.FecharVenda;
begin
  if not DtMdlMovVenda.VendaPagamento.isRegistroAtivo then
    FraPagamento.AdicionaPagamento(1,'Dinheiro','01',FTotalVendido);
  if FraPagamento.TotalAVender <> 0 then
    FraPagamento.AdicionaPagamento(1,'Dinheiro','01',FraPagamento.TotalAVender);
  ControlaBD.TelaAtual := ControlaTela.Codigo;
  ControlaBD.SetValorCampo('TOTALCUSTO',FraVendaProduto.ControlaBDItem.SubTotalizaCusto);
  if ControlaBD.Salva then
  begin
    if not DtMdlMovVenda.FuncaoECF.FechaVenda then
    begin
      ControlaBD.Edita;
      exit;
    end;
    with FraVendaProduto.ControlaBDItem.ClientDataSet do
    begin
      First;
      while not Eof do
      begin
        DtMdlCadProduto.Produto.LocalizaProduto(
          FraVendaProduto.ControlaBDItem.GetValorCampo('IDPRODUTO'));
        DtMdlCadProduto.Produto.Edita;
        DtMdlCadProduto.Produto.RetiraEstoque(
          FraVendaProduto.ControlaBDItem.GetValorCampoFloat('QUANTIDADE'));
        DtMdlCadProduto.Produto.Salva;
        Next;
      end;
      DtMdlCadProduto.Produto.AplicaModificacoes;
    end;
    ControlaBD.AplicaModificacoes;
    FraVendaProduto.ControlaBDItem.AplicaModificacoes;
    DtMdlMovVenda.VendaPagamento.AplicaModificacoes;
  end
  else begin
    ControlaBD.CancelaModificacoes(False);
    FraVendaProduto.ControlaBDItem.CancelaModificacoes(False);
    DtMdlMovVenda.VendaPagamento.CancelaModificacoes(False);
    DtMdlMovVenda.FuncaoECF.CancelaCupom;
  end;
  Close;
end;

procedure TCadVenda.FormCreate(Sender: TObject);
begin
  inherited;
  ControlaBD := DtMdlMovVenda.Venda;
  ControlaBD.Abre;
  FraVendaProduto.ControlaBDItem := DtMdlMovVenda.VendaProduto;
  FraVendaProduto.TipoMov := [tpVenda];
  FraVendaProduto.IDVenda := ControlaBD.GetValorCampoInt('IDVENDA');
  FraVendaProduto.FuncaoECF := DtMdlMovVenda.FuncaoECF;
  FraPagamento.ControlaBDPagamento := DtMdlMovVenda.VendaPagamento;
  FraPagamento.TipoMov := [tpVenda];
  FraPagamento.FuncaoECF := DtMdlMovVenda.FuncaoECF;
  FraPagamento.DlgPsqPagamento := DtMdlMovVenda.DlgPsqFormaPagamento;
  DtSrcGeral.DataSet := ControlaBD.ClientDataSet;
  if not ControlaTela.RegistraLog(ControlaTela.Codigo,4,ControlaTela.Rotulo) then
    Self.Tag := 96{AcessoNegado}
end;

procedure TCadVenda.FormShow(Sender: TObject);
begin
  inherited;
  TBShetFechaVenda.TabVisible := False;
end;

function TCadVenda.GetDesconto: double;
var
  strDescAcre : string;
  Continua: boolean;
begin
  repeat
    strDescAcre := '0';
    Continua := True;
    if not InputQuery('Acrescimo ou Desconto','Digite o valor positivo para acrescimo ou'+
      ' negativo para desconto.Ex.: "15,5"(acrescimo de R$ 15,50), "-10"(desconto de '+
      'R$ 10,00):',strDescAcre) then
      Abort;
    Result := StrToFloatDef(strDescAcre,0);
    if Result = 0 then
      Break;
    if (Result > 0) and (Result < 1) then
      Continua := False
    else if (Result < 0) and (Result > -1) then
      Continua := False;
    if not Continua then
      Mensagem('Digite um valor maior ou igual a 1,00');
  until (continua);
end;

procedure TCadVenda.sBtBtnBuscaVendedorClick(Sender: TObject);
var
  strValor: string;
begin
  inherited;
  if DtMdlConfig.DlgPsqUsuario.Executa then
  begin
    strValor := DtMdlConfig.DlgPsqUsuario.ValoresCamposRetornados[0];
    DtMdlMovVenda.Venda.SetValorCampo(
      'IDVENDEDOR',strValor);
  end;
end;

procedure TCadVenda.sBtBtnCadClienteClick(Sender: TObject);
begin
  inherited;
  DtMdlGeral.AbreNovo(TCadCliente);
  DtMdlCadCliente.CntrlBDCliente.Reabre;
end;

procedure TCadVenda.sBtBtnCadVendedorClick(Sender: TObject);
begin
  inherited;
  DtMdlGeral.AbreNovo(TCadUsuario);
  DtMdlConfig.CntrlBDUsuario.Reabre;
end;

procedure TCadVenda.sBtBtnCancelarClick(Sender: TObject);
begin
  if ControlaBD.CancelaModificacoes then
  begin
    FraVendaProduto.ControlaBDItem.CancelaModificacoes(False);
    DtMdlMovVenda.FuncaoECF.CancelaCupom;
    Close;
  end;
end;

procedure TCadVenda.sBtBtnPesquisaClienteClick(Sender: TObject);
var
  strValor: string;
begin
  inherited;
  if DtMdlCadCliente.DlgPsqCliente.Executa then
  begin
    strValor := DtMdlCadCliente.DlgPsqCliente.ValoresCamposRetornados[0];
    DtMdlMovVenda.Venda.SetValorCampo(
      'IDCLIENTE',strValor);
  end;
end;

procedure TCadVenda.sBtBtnSalvarClick(Sender: TObject);
begin
  inherited;
  if not VerificaCampoVazio([dbEdtCliente, DBEdtVendedor],['Cliente','Vendedor']) then
    exit;
  if not FraVendaProduto.ControlaBDItem.isRegistroAtivo then
  begin
    Mensagem('Não é possivel Fechar uma Venda sem nenhum Item');
    exit;
  end;
  if TbShtVenda.TabVisible then
  begin
    SubTotalizaCupom(GetDesconto);
    TbShtVenda.TabVisible := False;
    TBShetFechaVenda.TabVisible := True;
  end
  else
    FecharVenda;
end;

procedure TCadVenda.sSkinProviderTitleButtons0MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ControlaTela.AbreHelpTela;
end;

procedure TCadVenda.SubTotalizaCupom(dblDesconto: double);
var
  dblSubTot: double;
begin
  ControlaBD.SetValorCampo('DESCACRE',dblDesconto);
  DtMdlMovVenda.FuncaoECF.SubTotalizaCupom(dblDesconto);
  dblSubTot := FraVendaProduto.ControlaBDItem.SubTotalizaVenda;
  FTotalVendido := dblSubTot - (dblDesconto *-1);
  ControlaBD.SetValorCampo('TOTALVENDA', FTotalVendido);
  With DtMdlMovVenda.VendaPagamento do
  begin
    Abre;
    IDVenda := ControlaBD.GetValorCampoInt('IDVENDA');
    FiltraPagamento;
    FraPagamento.TotalVendido := FTotalVendido;
  end;
end;

end.
