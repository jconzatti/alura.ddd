unit Escola.Evento.Ouvinte.AlunoMatriculado.Log;

interface

uses
   System.SysUtils,
   System.Generics.Collections,
   Escola.Evento.AlunoMatriculado,
   Escola.Evento.Ouvinte,
   Escola.Evento,
   Escola.Evento.Tipo;

type
   TEventoOuvinteAlunoMatriculadoLog = class(TEventoOuvinte)
   protected
      procedure ReagirAo(pEvento : TEvento); override;
      function DeveProcessar(pEvento : TEvento): Boolean; override;
   end;

implementation

{ TEventoOuvinteAlunoMatriculadoLog }

procedure TEventoOuvinteAlunoMatriculadoLog.ReagirAo(pEvento: TEvento);
var lMapaInformacao : TDictionary<String,String>;
begin
   inherited;
   lMapaInformacao := pEvento.MapaInformacao;
   try
      Writeln(Format('Aluno com CPF %s matriculado com sucesso em %s!',
                     [lMapaInformacao.Items['aluno.cpf'],
                      FormatDateTime('dd/mm/yyyy "às" hh:nn', Now)]));

   finally
      lMapaInformacao.Destroy;
   end;
end;

function TEventoOuvinteAlunoMatriculadoLog.DeveProcessar(pEvento: TEvento): Boolean;
begin
   Result := pEvento.Tipo = etAlunoMatriculado;
end;

end.
