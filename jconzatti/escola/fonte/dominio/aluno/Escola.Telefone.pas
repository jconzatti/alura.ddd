unit Escola.Telefone;

interface

uses
   System.SysUtils,
   System.RegularExpressions,
   Escola.Telefone.Excecao;

type
   TTelefone = class
   private
      FDDD: String;
      FNumero: String;
      const EXPRESSAO_REGULAR_DDD = '^\d{2}$';
      const EXPRESSAO_REGULAR_NUMERO = '^\d{8,9}$';
      procedure Validar;
      procedure ValidarFormatoDDD;
      procedure ValidarFormatoNumero;
   public
      constructor Create(pDDD, pNumero : String);
      property DDD: String read FDDD;
      property Numero: String read FNumero;
   end;

implementation

{ TTelefone }

constructor TTelefone.Create(pDDD, pNumero : String);
begin
   FDDD    := pDDD;
   FNumero := pNumero;
   Validar;
end;

procedure TTelefone.Validar;
begin
   ValidarFormatoDDD;
   ValidarFormatoNumero;
end;

procedure TTelefone.ValidarFormatoDDD;
begin
   if not TRegEx.IsMatch(FDDD, EXPRESSAO_REGULAR_DDD) then
      raise ETelefoneDDDFormatoInvalido.Create(Format('Telefone com DDD %s com formato inválido!', [FDDD]));
end;

procedure TTelefone.ValidarFormatoNumero;
begin
   if not TRegEx.IsMatch(FNumero, EXPRESSAO_REGULAR_NUMERO) then
      raise ETelefoneNumeroFormatoInvalido.Create(Format('Telefone com número %s com formato inválido!', [FNumero]));
end;

end.
