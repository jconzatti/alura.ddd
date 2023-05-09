unit Escola.Email.Excecao;

interface

uses
   System.SysUtils;

type
   EEmailFormatoInvalido = class(EArgumentException)
   public
      constructor Create(pEmail : String); reintroduce;
   end;

implementation

{ EEmailFormatoInvalido }

constructor EEmailFormatoInvalido.Create(pEmail: String);
begin
   inherited Create(Format('e-mail "%s" com formato inválido!', [pEmail]));
end;

end.
