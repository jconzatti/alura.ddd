unit Escola.Email.Teste;

interface

uses
   DUnitX.TestFramework,
   Escola.Email,
   Escola.Email.Excecao;

type
   [TestFixture]
   TEmailTeste = class(TObject)
   public
      [Test]
      [TestCase('TestarEmailVazio', '')]
      [TestCase('TestarEmailSemArroba', 'jhoni.conzattigmail.com')]
      [TestCase('TestarEmailSemDominio', 'jhoni.conzatti@')]
      [TestCase('TestarEmailComDominioIncompleto', 'jhoni.conzatti@gmail')]
      [TestCase('TestarEmailSemUsuario', '@gmail.com')]
      [TestCase('TestarEmailComDoisArrobas', 'jhoni@bluway@gmail.com')]
      procedure TestarEmailComFormatoInvalido(pEnderecoEmail : String);
      [Test]
      procedure TestarEmailComFormatoValido;
   end;

implementation


{ TEmailTeste }

procedure TEmailTeste.TestarEmailComFormatoInvalido(pEnderecoEmail : String);
begin
   Assert.WillRaise(
      procedure
      var aEmail : TEmail;
      begin
         aEmail := TEmail.Create(pEnderecoEmail);
         aEmail.Destroy;
      end,
      EEmailFormatoInvalido
   );
end;

procedure TEmailTeste.TestarEmailComFormatoValido;
var aEmail : TEmail;
begin
   aEmail := TEmail.Create('jhoni@bluway.com.br');
   try
      Assert.AreEqual('jhoni@bluway.com.br', aEmail.Valor);
   finally
      aEmail.Destroy;
   end;
end;

initialization
   TDUnitX.RegisterTestFixture(TEmailTeste);
end.
