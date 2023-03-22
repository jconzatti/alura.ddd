unit Escola.Aluno.Repositorio;

interface

uses
   System.Generics.Collections,
   Escola.Aluno,
   Escola.CPF;

type
   TAlunoRepositorio = class abstract
   public
      procedure Matricular(pAluno : TAluno); virtual; abstract;
      function BuscarPorCPF(pCPF : TCPF): TAluno; virtual; abstract;
      function ListarTodoAlunoMatriculado: TObjectList<TAluno>; virtual; abstract;
   end;

implementation

end.
