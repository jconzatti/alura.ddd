program escola.ddd.dunit;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Escola.CPF.Teste in 'teste\dominio\aluno\Escola.CPF.Teste.pas',
  Escola.Email.Teste in 'teste\dominio\aluno\Escola.Email.Teste.pas',
  Escola.Telefone.Teste in 'teste\dominio\aluno\Escola.Telefone.Teste.pas',
  Escola.CPF.Excecao in 'fonte\dominio\aluno\Escola.CPF.Excecao.pas',
  Escola.CPF in 'fonte\dominio\aluno\Escola.CPF.pas',
  Escola.Email.Excecao in 'fonte\dominio\aluno\Escola.Email.Excecao.pas',
  Escola.Email in 'fonte\dominio\aluno\Escola.Email.pas',
  Escola.Telefone.Excecao in 'fonte\dominio\aluno\Escola.Telefone.Excecao.pas',
  Escola.Telefone in 'fonte\dominio\aluno\Escola.Telefone.pas',
  Escola.Aluno.Matriculador in 'fonte\aplicacao\aluno\Escola.Aluno.Matriculador.pas',
  Escola.Aluno.Dado in 'fonte\dominio\aluno\Escola.Aluno.Dado.pas',
  Escola.Aluno.Repositorio.Excecao in 'fonte\dominio\aluno\Escola.Aluno.Repositorio.Excecao.pas',
  Escola.Aluno.Repositorio in 'fonte\dominio\aluno\Escola.Aluno.Repositorio.pas',
  Escola.Aluno in 'fonte\dominio\aluno\Escola.Aluno.pas',
  Escola.Aluno.Matriculador.Teste in 'teste\aplicacao\aluno\Escola.Aluno.Matriculador.Teste.pas',
  Escola.Aluno.Repositorio.Memoria in 'fonte\infra\aluno\Escola.Aluno.Repositorio.Memoria.pas',
  Escola.Aluno.Teste in 'teste\dominio\aluno\Escola.Aluno.Teste.pas',
  Escola.Aluno.Excecao in 'fonte\dominio\aluno\Escola.Aluno.Excecao.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
