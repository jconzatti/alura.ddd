unit Escola.CPF.Excecao;

interface

uses
   System.SysUtils;

type
   ECPFFormatoInvalido = class(EArgumentException)
   public
      constructor Create(pCPF : String); reintroduce;
   end;

   ECPFDigitoVerificadorInvalido = class(EArgumentException)
   public
      constructor Create(pCPF : String); reintroduce;
   end;

implementation

{ ECPFFormatoInvalido }

constructor ECPFFormatoInvalido.Create(pCPF: String);
begin
   inherited Create(Format('CPF "%s" com formato inválido!', [pCPF]));
end;

{ ECPFDigitoVerificadorInvalido }

constructor ECPFDigitoVerificadorInvalido.Create(pCPF: String);
begin
   inherited Create(Format('CPF "%s" com dígito verificador inválido!', [pCPF]));
end;

end.
