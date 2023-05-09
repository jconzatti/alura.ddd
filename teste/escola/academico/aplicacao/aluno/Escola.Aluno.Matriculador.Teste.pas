unit Escola.Aluno.Matriculador.Teste;

interface

uses
   DUnitX.TestFramework,
   Escola.Aluno.Repositorio,
   Escola.Aluno.Repositorio.Memoria,
   Escola.Aluno.Matriculador,
   Escola.Aluno.Dado,
   Escola.Aluno, Escola.CPF;

type

   [TestFixture]
   TAlunoMatriculadorTeste = class(TObject)
   private
      FAlunoRepositorio : TAlunoRepositorio;
      FAlunoMatriculador : TAlunoMatriculador;
   public
      [Setup]
      procedure Inicializar;
      [TearDown]
      procedure Finalizar;
      [Test]
      procedure TestarSeOAlunoMatriculadoFoiGravadoNoRepositorio;
   end;

implementation

{ TAlunoMatriculadorTeste }

procedure TAlunoMatriculadorTeste.Inicializar;
begin
   FAlunoRepositorio := TAlunoRepositorioMemoria.Create;
   FAlunoMatriculador := TAlunoMatriculador.Create(FAlunoRepositorio);
end;

procedure TAlunoMatriculadorTeste.TestarSeOAlunoMatriculadoFoiGravadoNoRepositorio;
var lAlunoDado : TAlunoDado;
    lAluno : TAluno;
    lCPF : TCPF;
begin
   lAlunoDado.Nome := 'Jhoni Conzatti';
   lAlunoDado.CPF  := '066.829.429-90';
   lAlunoDado.Email:= 'jhoni.conzatti@gmail.com';
   FAlunoMatriculador.Matricular(lAlunoDado);
   lCPF := TCPF.Create(lAlunoDado.CPF);
   try
      lAluno := FAlunoRepositorio.BuscarPorCPF(lCPF);
      try
         Assert.AreEqual(lAluno.CPF.Valor, lAlunoDado.CPF);
         Assert.AreEqual(lAluno.Email.Valor, lAlunoDado.Email);
         Assert.AreEqual(lAluno.Nome, lAlunoDado.Nome);
      finally
         lAluno.Destroy;
      end;
   finally
      lCPF.Destroy;
   end;
end;

procedure TAlunoMatriculadorTeste.Finalizar;
begin
   FAlunoMatriculador.Destroy;
   FAlunoRepositorio.Destroy;
end;

initialization
   TDUnitX.RegisterTestFixture(TAlunoMatriculadorTeste);
end.
