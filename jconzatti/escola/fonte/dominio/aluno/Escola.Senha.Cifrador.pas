unit Escola.Senha.Cifrador;

interface

uses
   System.SysUtils;

type
   TSenhaCifrador = class abstract
   public
      function Cifrar(pSenha : String): String; virtual; abstract;
      function Validar(pSenhaCifrada, pSenha : String): Boolean;
   end;

implementation

{ TSenhaCifrador }

function TSenhaCifrador.Validar(pSenhaCifrada, pSenha: String): Boolean;
begin
   Result := pSenhaCifrada.Equals(Cifrar(pSenha));
end;

end.
