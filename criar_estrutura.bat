@echo off
REM Copyright © Luís Garcês — Todos os direitos reservados
REM Contacto: 915 020 614 | activecop@gmail.com

echo A iniciar a criacao da estrutura do Agente de Trading Autonomo...

set BASE_DIR=trading-agent

REM Criar diretorios
mkdir "%BASE_DIR%\backend\app\core"
mkdir "%BASE_DIR%\backend\app\exchanges"
mkdir "%BASE_DIR%\backend\app\engine"
mkdir "%BASE_DIR%\backend\app\exporter"
mkdir "%BASE_DIR%\backend\app\api"
mkdir "%BASE_DIR%\backend\tests"
mkdir "%BASE_DIR%\frontend\src\app"
mkdir "%BASE_DIR%\frontend\src\components"
mkdir "%BASE_DIR%\frontend\src\lib"

cd "%BASE_DIR%" || exit /b

REM Função simulada para criar leia-me.txt (usando blocos echo)
call :CriarLeiaMe "." "Raiz do Projeto" "Ponto de entrada do monorepo. Contem orquestracao, documentacao e variaveis de ambiente." ".env.example, docker-compose.yml, README.md, LICENSE" "Definir TRADING_MODE=PAPER, gerar FERNET_KEY, configurar DATABASE_URL."

call :CriarLeiaMe "backend" "Backend (Python/FastAPI)" "Logica principal do servidor, motores de trading e API." "pyproject.toml, app/, tests/" "Instalar dependencias via 'uv pip install' ou 'poetry install'."

call :CriarLeiaMe "backend\app\core" "Nucleo do Backend" "Gestao de configuracoes, seguranca e agendamento de tarefas." "config.py, security.py, scheduler.py" "Variaveis de ambiente carregadas via pydantic-settings. Chaves de API cifradas com Fernet."

call :CriarLeiaMe "backend\app\exchanges" "Conectores de Exchange" "Adaptadores para comunicacao com Binance e Coinbase." "adapter.py, binance_conn.py, coinbase_conn.py" "Chaves API no .env com permissoes APENAS 'Read' e 'Trade'. Rate limiting ativo."

call :CriarLeiaMe "backend\app\engine" "Motor de Trading" "Calculo de metricas, estrategias, gestao de risco e execucao de ordens." "metrics.py, strategies.py, risk_manager.py, executor.py" "MAX_DAILY_DRAWDOWN_PCT e MAX_POSITION_SIZE_PCT configurados no .env."

call :CriarLeiaMe "backend\app\exporter" "Exportacao de Logs" "Geracao de relatorios profissionais em multiplos formatos." "log_exporter.py" "Dependencias: reportlab (PDF). Geracao assincrona para nao bloquear a UI."

call :CriarLeiaMe "backend\app\api" "Camada de API" "Endpoints REST e validacao de dados." "routes.py, models.py" "Modelos Pydantic para validacao estrita de inputs. CORS configurado para o frontend."

call :CriarLeiaMe "backend\tests" "Testes Unitarios" "Validacao automatica das estrategias e do gestor de risco." "test_strategies.py, test_risk_manager.py" "Executar com 'pytest'. Mock de respostas de exchange para testes isolados."

call :CriarLeiaMe "frontend" "Frontend (Next.js)" "Interface de utilizador, dashboard e gestao de temas." "package.json, tailwind.config.js, src/" "Executar 'npm install' e 'npm run dev'. Tema escuro por defeito."

call :CriarLeiaMe "frontend\src\app" "Rotas e Layout" "Ponto de entrada da aplicacao React, layout global e anti-FOUC." "layout.tsx, page.tsx" "Script inline no ^<head^> para prevenir flash de tema claro. ThemeProvider ativo."

call :CriarLeiaMe "frontend\src\components" "Componentes UI" "Blocos de construcao reutilizaveis da interface." "ThemeToggle.tsx, Dashboard.tsx, KillSwitch.tsx, Footer.tsx" "Tailwind CSS com cores personalizadas (#0B0E11 para dark, #F5F5F5 para light)."

call :CriarLeiaMe "frontend\src\lib" "Bibliotecas e Utilitarios" "Funcoes auxiliares e logica de negocio do lado do cliente." "theme.ts" "Logica de leitura de localStorage e prefers-color-scheme."

REM Criar ficheiros base vazios
type nul > ".env.example"
type nul > "docker-compose.yml"
type nul > "README.md"
type nul > "LICENSE"
type nul > "backend\pyproject.toml"
type nul > "backend\app\main.py"
type nul > "backend\app\core\config.py"
type nul > "backend\app\core\security.py"
type nul > "backend\app\core\scheduler.py"
type nul > "backend\app\exchanges\adapter.py"
type nul > "backend\app\exchanges\binance_conn.py"
type nul > "backend\app\exchanges\coinbase_conn.py"
type nul > "backend\app\engine\metrics.py"
type nul > "backend\app\engine\strategies.py"
type nul > "backend\app\engine\risk_manager.py"
type nul > "backend\app\engine\executor.py"
type nul > "backend\app\exporter\log_exporter.py"
type nul > "backend\app\api\routes.py"
type nul > "backend\app\api\models.py"
type nul > "backend\tests\test_strategies.py"
type nul > "backend\tests\test_risk_manager.py"
type nul > "frontend\package.json"
type nul > "frontend\tailwind.config.js"
type nul > "frontend\src\app\layout.tsx"
type nul > "frontend\src\app\page.tsx"
type nul > "frontend\src\components\ThemeToggle.tsx"
type nul > "frontend\src\components\Dashboard.tsx"
type nul > "frontend\src\components\KillSwitch.tsx"
type nul > "frontend\src\components\Footer.tsx"
type nul > "frontend\src\lib\theme.ts"

echo Estrutura criada com sucesso em %CD%!
pause
exit /b

:CriarLeiaMe
(
echo ================================================================================
echo Copyright © Luís Garcês — Todos os direitos reservados
echo Contacto: 915 020 614 | activecop@gmail.com
echo ================================================================================
echo.
echo DIRETORIA: %~2
echo --------------------------------------------------------------------------------
echo DESCRICAO:
echo %~3
echo.
echo FICHEIROS ESPERADOS:
echo %~4
echo.
echo CONFIGURACOES APLICAVEIS:
echo %~5
echo ================================================================================
) > "%~1\leia-me.txt"
exit /b