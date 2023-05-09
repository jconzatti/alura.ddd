unit Escola.Selo;

interface

uses
   Escola.CPF,
   Escola.Selo.Dado;

type
   TSelo = class
   private
      FCPFAluno  : TCPF;
      FTitulo    : String;
      FDescricao : String;
   public
      constructor Create(pSeloDado : TSeloDado);
      destructor Destroy; override;
      property CPFAluno: TCPF read FCPFAluno;
      property Titulo: String read FTitulo;
      property Descricao: String read FDescricao;
   end;

implementation

{ TSelo }

constructor TSelo.Create(pSeloDado: TSeloDado);
begin
   FCPFAluno := TCPF.Create(pSeloDado.CPFAluno);
   FTitulo   := pSeloDado.Titulo;
   FDescricao:= pSeloDado.Descricao;
end;

destructor TSelo.Destroy;
begin
   FCPFAluno.Destroy;
   inherited;
end;

end.
