unit Escola.Senha.Cifrador.SHA256.Indy;

interface

uses
   Escola.Senha.Cifrador,
   IdHashSHA;

type
   TSenhaCifradorSHA256Indy = class(TSenhaCifrador)
   private
      FIdHashSHA265 : TIdHashSHA256;
   public
      constructor Create;
      destructor Destroy; override;
      function Cifrar(pSenha : String): String; override;
   end;

implementation

{ TSenhaCifradorSHA256Indy }

constructor TSenhaCifradorSHA256Indy.Create;
begin
   FIdHashSHA265 := TIdHashSHA256.Create;
end;

destructor TSenhaCifradorSHA256Indy.Destroy;
begin
   FIdHashSHA265.Destroy;
   inherited;
end;

function TSenhaCifradorSHA256Indy.Cifrar(pSenha: String): String;
begin
   Result := FIdHashSHA265.HashStringAsHex(pSenha);
end;

end.
