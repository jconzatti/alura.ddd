unit Escola.Aluno.Repositorio.FireDAC;

interface

uses
   System.SysUtils,
   System.Generics.Collections,
   Escola.Aluno,
   Escola.Aluno.Dado,
   Escola.CPF,
   Escola.Telefone,
   Escola.Aluno.Repositorio,
   Escola.Aluno.Repositorio.Excecao,
   Data.DB,
   FireDAC.Stan.Intf,
   FireDAC.Stan.Option,
   FireDAC.Stan.Error,
   FireDAC.UI.Intf,
   FireDAC.Phys.Intf,
   FireDAC.Stan.Def,
   FireDAC.Stan.Pool,
   FireDAC.Stan.Async,
   FireDAC.Phys,
   FireDAC.ConsoleUI.Wait,
   FireDAC.Comp.Client;

type
   TAlunoRepositorioFireDAC = class(TAlunoRepositorio)
   private
      FConexao : TFDConnection;
      const SQL_SELECT_ALUNO : String = 'SELECT ID, NOME, EMAIL, CPF FROM ALUNO';
      const SQL_SELECT_TELEFONE : String = 'SELECT ID, IDALUNO, DDD, NUMERO FROM TELEFONE';
   public
      constructor Create(pConexao : TFDConnection); reintroduce;
      procedure Matricular(pAluno : TAluno); override;
      function BuscarPorCPF(pCPF : TCPF): TAluno; override;
      function ListarTodoAlunoMatriculado: TObjectList<TAluno>; override;
   end;

implementation

{ TAlunoRepositorioFireDAC }

constructor TAlunoRepositorioFireDAC.Create(pConexao: TFDConnection);
begin
   FConexao := pConexao;
end;

procedure TAlunoRepositorioFireDAC.Matricular(pAluno: TAluno);
var lFDQueryAluno, lFDQueryTelefone : TFDQuery;
    lTelefone : TTelefone;
begin
   inherited;
   lFDQueryAluno := TFDQuery.Create(nil);
   try
      lFDQueryAluno.Connection := FConexao;
      lFDQueryAluno.Open(SQL_SELECT_ALUNO+' WHERE 1 = 0');
      lFDQueryAluno.Insert;
      lFDQueryAluno.FieldByName('NOME').AsString  := pAluno.Nome;
      lFDQueryAluno.FieldByName('EMAIL').AsString := pAluno.Email.Valor;
      lFDQueryAluno.FieldByName('CPF').AsString   := pAluno.CPF.Valor;
      lFDQueryAluno.Post;

      lFDQueryTelefone := TFDQuery.Create(nil);
      try
         lFDQueryTelefone.Connection := FConexao;
         lFDQueryTelefone.Open(SQL_SELECT_TELEFONE+' WHERE IDALUNO = :IDALUNO',
                               [lFDQueryAluno.FieldByName('ID').AsInteger], [ftInteger]);

         for lTelefone in pAluno.ListaTelefone do
         begin
            lFDQueryTelefone.Insert;
            lFDQueryTelefone.FieldByName('IDALUNO').AsInteger := lFDQueryAluno.FieldByName('ID').AsInteger;
            lFDQueryTelefone.FieldByName('DDD').AsString      := lTelefone.DDD;
            lFDQueryTelefone.FieldByName('NUMERO').AsString   := lTelefone.Numero;
            lFDQueryTelefone.Post;
         end;
      finally
         lFDQueryTelefone.Destroy;
      end;
   finally
      lFDQueryAluno.Destroy;
   end;
end;

function TAlunoRepositorioFireDAC.BuscarPorCPF(pCPF: TCPF): TAluno;
var lFDQueryAluno, lFDQueryTelefone : TFDQuery;
    lAlunoDado: TAlunoDado;
begin
   lFDQueryAluno := TFDQuery.Create(nil);
   try
      lFDQueryAluno.Connection := FConexao;
      lFDQueryAluno.Open(SQL_SELECT_ALUNO+' WHERE CPF = :CPF', [pCPF.Valor]);
      lFDQueryAluno.First;
      if lFDQueryAluno.Eof then
         raise EAlunoNaoEncontrado.Create(pCPF);

      lAlunoDado.Nome  := lFDQueryAluno.FieldByName('NOME').AsString;
      lAlunoDado.Email := lFDQueryAluno.FieldByName('EMAIL').AsString;
      lAlunoDado.CPF   := pCPF.Valor;
      Result := TAluno.Create(lAlunoDado);  
      try      
         lFDQueryTelefone := TFDQuery.Create(nil);
         try
            lFDQueryTelefone.Connection := FConexao;
            lFDQueryTelefone.Open(SQL_SELECT_TELEFONE+
                                  ' WHERE IDALUNO = :IDALUNO',
                                  [lFDQueryAluno.FieldByName('ID').AsInteger], 
                                  [ftInteger]);
            lFDQueryTelefone.First;
            while not lFDQueryTelefone.Eof do
            begin
               Result.AdicionarTelefone(lFDQueryTelefone.FieldByName('DDD').AsString,
                                        lFDQueryTelefone.FieldByName('NUMERO').AsString);
               lFDQueryTelefone.Next;
            end;
         finally
            lFDQueryTelefone.Destroy;
         end;
      except
         Result.Destroy;
         raise;
      end;
   finally
      lFDQueryAluno.Destroy;
   end;
end;

function TAlunoRepositorioFireDAC.ListarTodoAlunoMatriculado: TObjectList<TAluno>;
var lFDQueryAluno, lFDQueryTelefone : TFDQuery;
    lAlunoDado: TAlunoDado;
    I : Integer;
begin
   Result := TObjectList<TAluno>.Create;
   try
      lFDQueryAluno := TFDQuery.Create(nil);
      try
         lFDQueryAluno.Connection := FConexao;
         lFDQueryAluno.Open(SQL_SELECT_ALUNO);
         lFDQueryAluno.First;
         while not lFDQueryAluno.Eof do
         begin
            lAlunoDado.Nome  := lFDQueryAluno.FieldByName('NOME').AsString;
            lAlunoDado.Email := lFDQueryAluno.FieldByName('EMAIL').AsString;
            lAlunoDado.CPF   := lFDQueryAluno.FieldByName('CPF').AsString; 
            I := Result.Add(TAluno.Create(lAlunoDado));
            
            lFDQueryTelefone := TFDQuery.Create(nil);
            try
               lFDQueryTelefone.Connection := FConexao;
               lFDQueryTelefone.Open(SQL_SELECT_TELEFONE+
                                     ' WHERE IDALUNO = :IDALUNO',
                                     [lFDQueryAluno.FieldByName('ID').AsInteger], 
                                     [ftInteger]);
               lFDQueryTelefone.First;
               while not lFDQueryTelefone.Eof do
               begin
                  Result.Items[I].AdicionarTelefone(lFDQueryTelefone.FieldByName('DDD').AsString,
                                                    lFDQueryTelefone.FieldByName('NUMERO').AsString);
                  lFDQueryTelefone.Next;
               end;
            finally
               lFDQueryTelefone.Destroy;
            end;
            lFDQueryAluno.Next;
         end;
      finally
         lFDQueryAluno.Destroy;
      end;
   except
      Result.Destroy;
      raise;
   end;
end;

end.
