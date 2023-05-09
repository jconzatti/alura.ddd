unit Escola.Telefone.Teste;

interface

uses
   DUnitX.TestFramework,
   Escola.Telefone,
   Escola.Telefone.Excecao;

type

   [TestFixture]
   TTelefoneTeste = class(TObject)
   public
      [Test]
      [TestCase('TestarTelefoneSemDDD', '')]
      [TestCase('TestarTelefoneComDDDComUmDigito', '4')]
      [TestCase('TestarTelefoneComDDDComTresDigitos', '456')]
      [TestCase('TestarTelefoneComDDDComLetras', 'AB')]
      procedure TestarTelefoneComDDDComFormatoInvalido(pDDD : String);
      [Test]
      [TestCase('TestarTelefoneSemNumero', '')]
      [TestCase('TestarTelefoneComNumeroComTresDigitos', '999')]
      [TestCase('TestarTelefoneComNumeroComDezDigitos', '9876543210')]
      [TestCase('TestarTelefoneComNumeroComLetras', 'A12345678')]
      procedure TestarTelefoneComNumeroComFormatoInvalido(pNumero : String);
      [Test]
      [TestCase('TestarTelefoneComDDD47ENumero984527792', '47,984527792')]
      [TestCase('TestarTelefoneComDDD47ENumero30355707', '47,30355707')]
      procedure TestarTelefoneComFormatoValido(pDDD, pNumero : String);
   end;

implementation


{ TTelefoneTeste }

{ TTelefoneTeste }

procedure TTelefoneTeste.TestarTelefoneComDDDComFormatoInvalido(pDDD: String);
begin
   Assert.WillRaise(
      procedure
      var aTelefone : TTelefone;
      begin
         aTelefone := TTelefone.Create(pDDD, '988887777');
         aTelefone.Destroy;
      end,
      ETelefoneDDDFormatoInvalido
   );
end;

procedure TTelefoneTeste.TestarTelefoneComNumeroComFormatoInvalido(pNumero: String);
begin
   Assert.WillRaise(
      procedure
      var aTelefone : TTelefone;
      begin
         aTelefone := TTelefone.Create('47', pNumero);
         aTelefone.Destroy;
      end,
      ETelefoneNumeroFormatoInvalido
   );
end;

procedure TTelefoneTeste.TestarTelefoneComFormatoValido(pDDD, pNumero: String);
var aTelefone : TTelefone;
begin
   aTelefone := TTelefone.Create(pDDD, pNumero);
   try
      Assert.AreEqual(aTelefone.DDD, pDDD);
      Assert.AreEqual(aTelefone.Numero, pNumero);
   finally
      aTelefone.Destroy;
   end;
end;

initialization
   TDUnitX.RegisterTestFixture(TTelefoneTeste);
end.
