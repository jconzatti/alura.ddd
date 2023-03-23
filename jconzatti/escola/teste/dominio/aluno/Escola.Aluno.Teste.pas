unit Escola.Aluno.Teste;

interface

uses
   DUnitX.TestFramework,
   Escola.Aluno,
   Escola.Aluno.Dado,
   Escola.Aluno.Excecao;

type
   [TestFixture]
   TAlunoTeste = class(TObject)
   private
      FAluno : TAluno;
   public
      [Setup]
      procedure Inicializar;
      [Test]
      procedure TestarSeEhPermitidoInformarUmTelefoneParaOAluno;
      [Test]
      procedure TestarSeEhPermitidoInformarDoisTelefonesParaOAluno;
      [Test]
      procedure TestarSeNaoEhPermitidoInformarMaisQueDoisTelefonesParaOAluno;
      [TearDown]
      procedure Finanlizar;
   end;

implementation

procedure TAlunoTeste.Inicializar;
var lAlunoDado : TAlunoDado;
begin
   lAlunoDado.Nome  := 'Thaís de Lima Silva';
   lAlunoDado.CPF   := '084.714.229-99';
   lAlunoDado.Email := 'thais.lima.silva@email.com';
   FAluno := TAluno.Create(lAlunoDado);
end;

procedure TAlunoTeste.TestarSeEhPermitidoInformarUmTelefoneParaOAluno;
begin
   FAluno.AdicionarTelefone('47','888888888');
   Assert.AreEqual(1, FAluno.ListaTelefone.Count);
   Assert.AreEqual('47', FAluno.ListaTelefone.Items[0].DDD);
   Assert.AreEqual('888888888', FAluno.ListaTelefone.Items[0].Numero);
end;

procedure TAlunoTeste.TestarSeEhPermitidoInformarDoisTelefonesParaOAluno;
begin
   FAluno.AdicionarTelefone('47','888888888');
   FAluno.AdicionarTelefone('48','999999999');
   Assert.AreEqual(2, FAluno.ListaTelefone.Count);
   Assert.AreEqual('47', FAluno.ListaTelefone.Items[0].DDD);
   Assert.AreEqual('888888888', FAluno.ListaTelefone.Items[0].Numero);
   Assert.AreEqual('48', FAluno.ListaTelefone.Items[1].DDD);
   Assert.AreEqual('999999999', FAluno.ListaTelefone.Items[1].Numero);
end;

procedure TAlunoTeste.TestarSeNaoEhPermitidoInformarMaisQueDoisTelefonesParaOAluno;
begin
   Assert.WillRaise(
      procedure
      begin
         FAluno.AdicionarTelefone('47','888888888');
         FAluno.AdicionarTelefone('48','999999999');
         FAluno.AdicionarTelefone('49','999999990');
      end,
      EAlunoQuantidadeTelefoneExcedido
   );
end;

procedure TAlunoTeste.Finanlizar;
begin
   FAluno.Destroy;
end;

initialization
   TDUnitX.RegisterTestFixture(TAlunoTeste);
end.
