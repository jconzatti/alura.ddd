unit Escola.Aluno.Repositorio.Memoria;

interface

uses
   System.SysUtils,
   System.Generics.Collections,
   Escola.Aluno.Repositorio,
   Escola.Aluno.Repositorio.Excecao,
   Escola.Aluno,
   Escola.Aluno.Dado,
   Escola.CPF;

type
   TAlunoRepositorioMemoria = class(TAlunoRepositorio)
   private
      FListaAluno : TObjectList<TAluno>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Matricular(pAluno : TAluno); override;
      function BuscarPorCPF(pCPF : TCPF): TAluno; override;
      function ListarTodoAlunoMatriculado: TObjectList<TAluno>; override;
   end;

implementation

{ TAlunoRepositorioMemoria }

constructor TAlunoRepositorioMemoria.Create;
begin
   FListaAluno := TObjectList<TAluno>.Create;
end;

destructor TAlunoRepositorioMemoria.Destroy;
begin
   FListaAluno.Destroy;
   inherited;
end;

procedure TAlunoRepositorioMemoria.Matricular(pAluno: TAluno);
var lAlunoDado: TAlunoDado;
begin
   inherited;
   lAlunoDado.Nome  := pAluno.Nome;
   lAlunoDado.CPF   := pAluno.CPF.Valor;
   lAlunoDado.Email := pAluno.Email.Valor;
   FListaAluno.Add(TAluno.Create(lAlunoDado));
end;

function TAlunoRepositorioMemoria.BuscarPorCPF(pCPF: TCPF): TAluno;
var lAluno: TAluno;
    lAlunoDado: TAlunoDado;
begin
   Result := nil;
   for lAluno in FListaAluno do
   begin
      if lAluno.CPF.Valor.Equals(pCPF.Valor) then
      begin
         lAlunoDado.Nome  := lAluno.Nome;
         lAlunoDado.CPF   := lAluno.CPF.Valor;
         lAlunoDado.Email := lAluno.Email.Valor;
         Result := TAluno.Create(lAlunoDado);
         Break;
      end;
   end;

   if not Assigned(Result) then
      raise EAlunoNaoEncontrado.Create(pCPF);
end;

function TAlunoRepositorioMemoria.ListarTodoAlunoMatriculado: TObjectList<TAluno>;
var lAluno: TAluno;
    lAlunoDado: TAlunoDado;
begin
   Result := TObjectList<TAluno>.Create;
   try
      for lAluno in FListaAluno do
      begin
         lAlunoDado.Nome  := lAluno.Nome;
         lAlunoDado.CPF   := lAluno.CPF.Valor;
         lAlunoDado.Email := lAluno.Email.Valor;
         Result.Add(TAluno.Create(lAlunoDado));
      end;
   except
      Result.Destroy;
      raise;
   end;
end;

end.
