unit Escola.CPF.Teste;

interface

uses
   DUnitX.TestFramework,
   Escola.CPF,
   Escola.CPF.Excecao;

type
   [TestFixture]
   TCPFTeste = class(TObject)
   public
      [Test]
      [TestCase('TestarCPFVazio', '')]
      [TestCase('TestarCPFSemPonto', '066829429-90')]
      [TestCase('TestarCPFSemTraco', '066.829.42990')]
      [TestCase('TestarCPFSemPontoESemTraco', '06682942990')]
      [TestCase('TestarCNPJNoLugarDoCPF', '03.522.601/0001-52')]
      [TestCase('TestarCPFComTresDigitosVerificadores', '066.829.429-900')]
      procedure TestarCPFComFormatoInvalido(pValor : String);
      [Test]
      procedure TestarCPFComDigitoVerificadorInvalido;
      [Test]
      procedure TestarCPFComDigitoVerificadorValido;
   end;

implementation


{ TCPFTeste }

procedure TCPFTeste.TestarCPFComFormatoInvalido(pValor: String);
begin
   Assert.WillRaise(
      procedure
      var aCPF : TCPF;
      begin
         aCPF := TCPF.Create(pValor);
         aCPF.Destroy;
      end,
      ECPFFormatoInvalido
   );
end;

procedure TCPFTeste.TestarCPFComDigitoVerificadorInvalido;
begin
   Assert.WillRaise(
      procedure
      var aCPF : TCPF;
      begin
         aCPF := TCPF.Create('066.829.429-99');
         aCPF.Destroy;
      end,
      ECPFDigitoVerificadorInvalido
   );
end;

procedure TCPFTeste.TestarCPFComDigitoVerificadorValido;
var aCPF : TCPF;
begin
   aCPF := TCPF.Create('066.829.429-90');
   try
      Assert.AreEqual('066.829.429-90', aCPF.Valor);
   finally
      aCPF.Destroy;
   end;
end;

initialization
   TDUnitX.RegisterTestFixture(TCPFTeste);
end.
