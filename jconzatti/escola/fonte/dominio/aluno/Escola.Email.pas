unit Escola.Email;

interface

uses
   System.SysUtils,
   System.RegularExpressions,
   Escola.Email.Excecao;

type
   TEmail = class
   private
      FValor: String;
      const EXPRESSAO_REGULAR_EMAIL = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      procedure Validar;
   public
      constructor Create(pValor : String);
      property Valor: String read FValor;
   end;

implementation

{ TEmail }

constructor TEmail.Create(pValor: String);
begin
   FValor := pValor;
   Validar;
end;

procedure TEmail.Validar;
begin
   if not TRegEx.IsMatch(FValor, EXPRESSAO_REGULAR_EMAIL) then
      raise EEmailFormatoInvalido.Create(Format('e-mail %s com formato inválido!', [FValor]));
end;

end.
