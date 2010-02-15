inherited CadVenda: TCadVenda
  AutoSize = True
  Caption = 'Lan'#231'amento de Vendas'
  ClientHeight = 569
  ClientWidth = 905
  OnShow = FormShow
  ExplicitTop = -68
  ExplicitWidth = 913
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 521
    Width = 905
    ExplicitTop = 521
    ExplicitWidth = 905
    inherited sBtBtnCancelar: TsBitBtn
      Left = 768
      Width = 122
      ExplicitLeft = 768
      ExplicitWidth = 122
    end
    inherited sBtBtnSalvar: TsBitBtn
      Left = 624
      Width = 128
      Caption = '&Fechar Venda'
      ExplicitLeft = 624
      ExplicitWidth = 128
    end
  end
  inherited PgCtrlCadastro: TPageControl
    Width = 905
    Height = 521
    ActivePage = TbShtVenda
    ExplicitWidth = 905
    ExplicitHeight = 521
    object TbShtVenda: TTabSheet
      Caption = 'Dados Principais'
      object Label6: TLabel
        Left = 8
        Top = 15
        Width = 66
        Height = 16
        Alignment = taRightJustify
        Caption = 'Vendedor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 457
        Top = 15
        Width = 49
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object DBEdtVendedor: TDBEdit
        Left = 80
        Top = 14
        Width = 41
        Height = 21
        DataField = 'IDVENDEDOR'
        DataSource = DtSrcGeral
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = DBEdtVendedorExit
      end
      object dbEdtLkpNomeVendedor: TDBEdit
        Left = 127
        Top = 14
        Width = 258
        Height = 21
        TabStop = False
        DataField = 'lkpNOMEVENDEDOR'
        DataSource = DtSrcGeral
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        OnEnter = dbEdtLkpNomeVendedorEnter
      end
      object sBtBtnBuscaVendedor: TsBitBtn
        Left = 391
        Top = 13
        Width = 26
        Height = 24
        Hint = 'Abre uma tela para localiza'#231#227'o do campo requisitado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = sBtBtnBuscaVendedorClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 12
        Images = DtMdlGeral.sAlphaImageListBtn
      end
      object sBtBtnCadVendedor: TsBitBtn
        Left = 423
        Top = 13
        Width = 26
        Height = 24
        Hint = 'Abre a tela de Cadastro do campo ao lado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        TabStop = False
        OnClick = sBtBtnCadVendedorClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 1
        Images = DtMdlGeral.sAlphaImageListBtn
      end
      object dbEdtCliente: TDBEdit
        Left = 512
        Top = 14
        Width = 41
        Height = 21
        DataField = 'IDCLIENTE'
        DataSource = DtSrcGeral
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnExit = dbEdtClienteExit
      end
      object dbEdtlkpNomeCliente: TDBEdit
        Left = 559
        Top = 14
        Width = 258
        Height = 21
        TabStop = False
        DataField = 'lkpNOMECLIENTE'
        DataSource = DtSrcGeral
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        OnEnter = dbEdtlkpNomeClienteEnter
      end
      object sBtBtnPesquisaCliente: TsBitBtn
        Left = 823
        Top = 14
        Width = 26
        Height = 24
        Hint = 'Abre uma tela para localiza'#231#227'o do campo requisitado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = sBtBtnPesquisaClienteClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 12
        Images = DtMdlGeral.sAlphaImageListBtn
      end
      object sBtBtnCadCliente: TsBitBtn
        Left = 855
        Top = 14
        Width = 26
        Height = 24
        Hint = 'Abre a tela de Cadastro do campo ao lado'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        TabStop = False
        OnClick = sBtBtnCadClienteClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 1
        Images = DtMdlGeral.sAlphaImageListBtn
      end
      inline FraVendaProduto: TFraVendaProduto
        Left = 0
        Top = 43
        Width = 897
        Height = 450
        Align = alBottom
        TabOrder = 8
        ExplicitTop = 43
        ExplicitWidth = 897
        inherited Bevel1: TBevel
          Width = 897
          ExplicitWidth = 897
        end
        inherited sPanel1: TsPanel
          Width = 897
          ExplicitWidth = 897
          inherited LblItems: TLabel
            Left = 106
            ExplicitLeft = 106
          end
          inherited sLabel1: TsLabel
            Left = 106
            ExplicitLeft = 106
          end
          inherited lblSubTotal: TLabel
            Left = 735
            ExplicitLeft = 735
          end
          inherited JvDbGrdPesquisa1: TJvDBGrid
            Left = 103
          end
        end
        inherited GroupBox1: TGroupBox
          Width = 897
          ExplicitTop = 0
          ExplicitWidth = 897
          inherited Label3: TLabel
            Left = 85
            ExplicitLeft = 85
          end
          inherited Label4: TLabel
            Left = 471
            ExplicitLeft = 471
          end
          inherited Label5: TLabel
            Left = 523
            ExplicitLeft = 523
          end
          inherited Label7: TLabel
            Left = 676
            ExplicitLeft = 676
          end
          inherited LblEstoque: TLabel
            Left = 88
            ExplicitLeft = 88
          end
          inherited sBtBtnCadProduto: TsBitBtn
            Left = 764
            ExplicitLeft = 764
          end
          inherited sBtBtnProduto: TsBitBtn
            Left = 732
            ExplicitLeft = 732
          end
          inherited sBtBtnInserir: TsBitBtn
            Left = 796
            ExplicitLeft = 796
          end
          inherited EdtCodBarras: TEdit
            Left = 85
            ExplicitLeft = 85
          end
          inherited EdtNomeProduto: TEdit
            Left = 225
            ExplicitLeft = 225
          end
          inherited JvClcEdtQtde: TJvCalcEdit
            Left = 406
            ExplicitLeft = 406
          end
          inherited EdtAliquota: TEdit
            Left = 519
            ExplicitLeft = 519
          end
          inherited JvClcEdtPreco: TJvCalcEdit
            Left = 586
            ExplicitLeft = 586
          end
        end
      end
    end
    object TBShetFechaVenda: TTabSheet
      Caption = 'Fechamento da Venda'
      ImageIndex = 1
      inline FraPagamento: TFraPagamento
        Left = 162
        Top = 44
        Width = 586
        Height = 433
        TabOrder = 0
        ExplicitLeft = 162
        ExplicitTop = 44
      end
    end
  end
  inherited ControlaTela: TControlaTela
    Codigo = 9
    Rotulo = 'Vendas'
    Left = 520
    Top = 400
  end
  inherited DtSrcGeral: TDataSource
    Left = 520
    Top = 344
  end
  object sSkinProvider: TsSkinProvider
    CaptionAlignment = taCenter
    SkinData.SkinSection = 'FORM'
    ShowAppIcon = False
    TitleButtons = <
      item
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000BA5D2C10BC5F2C80C1622DDFC86731FFD2723BFFD67B43FFD478
          3EFFD16F32CFD572336000000000000000000000000000000000000000000000
          0000B65A2B30BA5C2BDFC96028FFD6682BFFDA7135FFDF7C3FFFE3894AFFE899
          5BFFECA96EFFE4975AFFDB7B3BCFDC773510000000000000000000000000B257
          2930B9592BEFCC5B29FFD26125FFD6692AFFE08F5EFFF0E2DEFFF0DACCFFEB96
          52FFEF9C52FFF5B46EFFF5BD7FFFDF7E3DCFDB7635100000000000000000B357
          2ACFC85E31FFCE5A22FFD26124FFD6692AFFE5AC8CFFF0E8E8FFF0E8E8FFECA6
          70FFEF9A4EFFF4A556FFF9B86FFFF1B677FFD87434AF00000000AE532860BC5E
          33FFCB5B28FFCE591EFFD16024FFD56729FFDB773BFFEAC5B1FFEABC9DFFE88C
          44FFEC954BFFF19D51FFF4A355FFF4B675FFDF8D50FFD3703330AC5228AFC86B
          42FFCA531BFFCD571DFFD05E22FFD46527FFE4AB8BFFF1EAEAFFF1E9E9FFE586
          40FFE98E46FFEC944AFFEE984DFFEE9C53FFE7A066FFD06E328FB25B33FFD178
          4FFFCB541DFFCC551CFFCF5B20FFD36225FFE09972FFF2EBEBFFF2EAEAFFE69B
          67FFE5863FFFE78B43FFE98E45FFE98E45FFE7995EFFCC6B31BFB56039FFD278
          4EFFD06532FFCD5821FFCE581EFFD15E23FFD46527FFEED4C8FFF3ECECFFEFD6
          CAFFE18444FFE2813CFFE3833EFFE3833EFFE28A50FFC96930BFB5613BFFD57E
          56FFD06634FFD16734FFD1632DFFCF5D23FFD26024FFD87640FFF2E5E2FFF3ED
          EDFFECC7B3FFDD7735FFDE7936FFDE7936FFDE7B43FFC5662FBFAA532CDFDA8E
          6CFFD06534FFD16634FFD26834FFD36B35FFD46A32FFD4682EFFDF9269FFF5EF
          EFFFF4EEEEFFDD7F47FFDA7030FFDA7030FFD87038FFC2632EAFA54C268FD18A
          6AFFD37245FFD06634FFD16734FFE9B9A2FFEECBBBFFDE8F66FFEBC2ADFFF6F2
          F2FFF5F0F0FFDE8B5CFFDA753BFFDA753BFFCF6D35FFBF602D60A44C2520B462
          3EFFDD9372FFD06534FFD6794DFFFEFDFDFFFCFBFBFFFBF8F8FFF9F6F6FFF8F5
          F5FFF3E2DBFFD66F37FFD77038FFD56F37FFBF602EEFBC5E2C1000000000A44B
          2580C77D5CFFDB8C69FFD06838FFD9825AFFF0CEBFFFFDFCFCFFFCFAFAFFEECB
          BAFFDA8559FFD46B36FFD46C39FFC2612FFFB85B2B5000000000000000000000
          0000A34B259FC37755FFDE9777FFD4784EFFD06838FFD06634FFD16634FFD169
          38FFD26E40FFD06D43FFBD5E31FFB4592A600000000000000000000000000000
          000000000000A34B2570AD5832EFC67B59FFCE8362FFD78C6BFFD48865FFC875
          4FFFBD653CFFB2572BDFB1562950000000000000000000000000000000000000
          00000000000000000000A44C2510A54C2660A64E268FA84F26BFA95027BFAB51
          2780AC5228500000000000000000000000000000000000000000}
        Name = 'TsTtlBtnConfig'
        OnMouseUp = sSkinProviderTitleButtons0MouseUp
      end>
    Left = 520
    Top = 288
  end
end
