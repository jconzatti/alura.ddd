unit Escola.CPF;

interface

uses
   System.SysUtils,
   System.RegularExpressions,
   Escola.CPF.Excecao;

type
   TCPF = class
   private
      FValor: String;
      const EXPRESSAO_REGULAR_CPF = '^\d{3}\.\d{3}\.\d{3}\-\d{2}$';
      procedure Validar;
      procedure ValidarFormato;
      procedure ValidarDigitoVerificador;
   public
      constructor Create(pValor : String);
      property Valor: String read FValor;
   end;

implementation

{ TCPF }

constructor TCPF.Create(pValor: String);
begin
   FValor := pValor;
   Validar;
end;

procedure TCPF.Validar;
begin
   ValidarFormato;
   ValidarDigitoVerificador;
end;

procedure TCPF.ValidarFormato;
begin
   if not TRegEx.IsMatch(FValor, EXPRESSAO_REGULAR_CPF) then
      raise ECPFFormatoInvalido.Create(Format('CPF %s com formato inválido!', [FValor]));
end;

procedure TCPF.ValidarDigitoVerificador;
var aCPFSemDigito, aDoisDigito: string;
    aDigito1, aDigito2, I: Integer;
begin
   aCPFSemDigito := FValor.Replace('.', '', [rfReplaceAll]);
   aCPFSemDigito := aCPFSemDigito.Substring(0,9);
   aDoisDigito   := FValor.Substring(12,2);

   aDigito1 := 0;
   for I := 1 to 9 do
      aDigito1 := aDigito1 + StrToIntDef(aCPFSemDigito[I], 0) * (11 - I);
   aDigito1 := 11 - (aDigito1 mod 11);
   if aDigito1 >= 10 then
      aDigito1 := 0;

   aCPFSemDigito := aCPFSemDigito + aDigito1.ToString;

   aDigito2 := 0;
   for I := 1 to 10 do
      aDigito2 := aDigito2 + StrToIntDef(aCPFSemDigito[I], 0) * (12 - I);
   aDigito2 := 11 - (aDigito2 mod 11);
   if aDigito2 >= 10 then
      aDigito2 := 0;

   aCPFSemDigito := aCPFSemDigito + aDigito2.ToString;

   if not aDoisDigito.Equals(aCPFSemDigito.Substring(9)) then
      raise ECPFDigitoVerificadorInvalido.Create(Format('CPF %s com dígito verificador inválido!', [FValor]));
end;

end.
