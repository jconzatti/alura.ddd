unit Escola.Evento.AlunoMatriculado;

interface

uses
   System.SysUtils,
   System.Generics.Collections,
   Escola.CPF,
   Escola.Evento,
   Escola.Evento.Tipo;

type
   TEventoAlunoMatriculado = class(TEvento)
   private
      FCPFAluno : TCPF;
      FMomento  : TDateTime;
   public
      constructor Create(pCPFAluno : TCPF);
      function Momento : TDateTime; override;
      function Tipo : TEventoTipo; override;
      function MapaInformacao: TDictionary<String, String>; override;
   end;

implementation

{ TEventoAlunoMatriculado }

constructor TEventoAlunoMatriculado.Create(pCPFAluno: TCPF);
begin
   FCPFAluno := pCPFAluno;
   FMomento  := Now;
end;

function TEventoAlunoMatriculado.Momento: TDateTime;
begin
   Result := FMomento;
end;

function TEventoAlunoMatriculado.Tipo: TEventoTipo;
begin
   Result := etAlunoMatriculado;
end;

function TEventoAlunoMatriculado.MapaInformacao: TDictionary<String, String>;
begin
   Result := TDictionary<String, String>.Create;
   try
      Result.Add('aluno.cpf', FCPFAluno.Valor);
   except
      Result.Destroy;
      raise;
   end;
end;

end.
