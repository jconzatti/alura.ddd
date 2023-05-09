unit Escola.Selo.Repositorio;

interface

uses
   System.Generics.Collections,
   Escola.Selo,
   Escola.CPF;

type
   TSeloRepositorio = class abstract
   public
      procedure Adicionar(pSelo : TSelo); virtual; abstract;
      function BuscarPorTitulo(pTitulo : String): TSelo; virtual; abstract;
      function ListarPorCPFDoAluno(pCPFAluno : TCPF): TObjectList<TSelo>; virtual; abstract;
      function ListarTodoSelo: TObjectList<TSelo>; virtual; abstract;
   end;

implementation

end.
