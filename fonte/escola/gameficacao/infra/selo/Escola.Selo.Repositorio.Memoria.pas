unit Escola.Selo.Repositorio.Memoria;

interface

uses
   System.SysUtils,
   System.Generics.Collections,
   Escola.Selo.Repositorio,
   Escola.Selo.Repositorio.Excecao,
   Escola.Selo,
   Escola.Selo.Dado,
   Escola.CPF;

type
   TSeloRepositorioMemoria = class(TSeloRepositorio)
   private
      FListaSelo : TObjectList<TSelo>;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(pSelo : TSelo); override;
      function BuscarPorTitulo(pTitulo : String): TSelo; override;
      function ListarPorCPFDoAluno(pCPFAluno : TCPF): TObjectList<TSelo>; override;
      function ListarTodoSelo: TObjectList<TSelo>; override;
   end;

implementation

{ TSeloRepositorioMemoria }

constructor TSeloRepositorioMemoria.Create;
begin
   FListaSelo := TObjectList<TSelo>.Create;
end;

destructor TSeloRepositorioMemoria.Destroy;
begin
   FListaSelo.Destroy;
   inherited;
end;

procedure TSeloRepositorioMemoria.Adicionar(pSelo: TSelo);
var lSeloDado: TSeloDado;
begin
   inherited;
   lSeloDado.CPFAluno := pSelo.CPFAluno.Valor;
   lSeloDado.Titulo   := pSelo.Titulo;
   lSeloDado.Descricao:= pSelo.Descricao;
   FListaSelo.Add(TSelo.Create(lSeloDado));
end;

function TSeloRepositorioMemoria.BuscarPorTitulo(pTitulo: String): TSelo;
var lSelo: TSelo;
    lSeloDado: TSeloDado;
begin
   Result := nil;
   for lSelo in FListaSelo do
   begin
      if lSelo.Titulo.ToUpper.Equals(pTitulo.ToUpper) then
      begin
         lSeloDado.CPFAluno := lSelo.CPFAluno.Valor;
         lSeloDado.Titulo   := lSelo.Titulo;
         lSeloDado.Descricao:= lSelo.Descricao;
         Result := TSelo.Create(lSeloDado);
         Break;
      end;
   end;

   if not Assigned(Result) then
      raise ESeloNaoEncontradoPorTitulo.Create(pTitulo);
end;

function TSeloRepositorioMemoria.ListarPorCPFDoAluno(pCPFAluno: TCPF): TObjectList<TSelo>;
var lSelo: TSelo;
    lSeloDado: TSeloDado;
begin
   Result := TObjectList<TSelo>.Create;
   try
      for lSelo in FListaSelo do
      begin
         if lSelo.CPFAluno.Valor.Equals(pCPFAluno.Valor) then
         begin
            lSeloDado.CPFAluno := lSelo.CPFAluno.Valor;
            lSeloDado.Titulo   := lSelo.Titulo;
            lSeloDado.Descricao:= lSelo.Descricao;
            Result.Add(TSelo.Create(lSeloDado));
         end;
      end;
   except
      Result.Destroy;
      raise;
   end;
end;

function TSeloRepositorioMemoria.ListarTodoSelo: TObjectList<TSelo>;
var lSelo: TSelo;
    lSeloDado: TSeloDado;
begin
   Result := TObjectList<TSelo>.Create;
   try
      for lSelo in FListaSelo do
      begin
         lSeloDado.CPFAluno := lSelo.CPFAluno.Valor;
         lSeloDado.Titulo   := lSelo.Titulo;
         lSeloDado.Descricao:= lSelo.Descricao;
         Result.Add(TSelo.Create(lSeloDado));
      end;
   except
      Result.Destroy;
      raise;
   end;
end;

end.
