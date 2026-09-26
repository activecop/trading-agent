# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

Write-Host "A iniciar a criação da estrutura do Agente de Trading Autónomo..." -ForegroundColor Green

$baseDir = "trading-agent"
New-Item -ItemType Directory -Force -Path "$baseDir/backend/app/core" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/backend/app/exchanges" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/backend/app/engine" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/backend/app/exporter" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/backend/app/api" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/backend/tests" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/frontend/src/app" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/frontend/src/components" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir/frontend/src/lib" | Out-Null

Set-Location $baseDir

function Criar-LeiaMe {
    param([string]$Dir, [string]$Titulo, [string]$Descricao, [string]$Ficheiros, [string]$Configs)
    
    $conteudo = @"
================================================================================
Copyright © Luís Garcês — Todos os direitos reservados
Contacto: 915 020 614 | activecop@gmail.com
================================================================================

DIRETÓRIA: $Titulo
--------------------------------------------------------------------------------
DESCRIÇÃO:
$Descricao

FICHEIROS ESPERADOS:
$Ficheiros

CONFIGURAÇÕES APLICÁVEIS:
$Configs
================================================================================
"@
    Set-Content -Path "$Dir/leia-me.txt" -Value $conteudo -Encoding UTF8
}

# --- ROOT ---
Criar-LeiaMe -Dir "." -Titulo "Raiz do Projeto" -Descricao "Ponto de entrada do monorepo. Contém orquestração, documentação e variáveis de ambiente." -Ficheiros ".env.example, docker-compose.yml, README.md, LICENSE" -Configs "Definir TRADING_MODE=PAPER, gerar FERNET_KEY, configurar DATABASE_URL."

# --- BACKEND ---
Criar-LeiaMe -Dir "backend" -Titulo "Backend (Python/FastAPI)" -Descricao "Lógica principal do servidor, motores de trading e API." -Ficheiros "pyproject.toml, app/, tests/" -Configs "Instalar dependências via 'uv pip install' ou 'poetry install'."
Criar-LeiaMe -Dir "backend/app/core" -Titulo "Núcleo do Backend" -Descricao "Gestão de configurações, segurança e agendamento de tarefas." -Ficheiros "config.py, security.py, scheduler.py" -Configs "Variáveis de ambiente carregadas via pydantic-settings. Chaves de API cifradas com Fernet."
Criar-LeiaMe -Dir "backend/app/exchanges" -Titulo "Conectores de Exchange" -Descricao "Adaptadores para comunicação com Binance e Coinbase." -Ficheiros "adapter.py, binance_conn.py, coinbase_conn.py" -Configs "Chaves API no .env com permissões APENAS 'Read' e 'Trade'. Rate limiting ativo."
Criar-LeiaMe -Dir "backend/app/engine" -Titulo "Motor de Trading" -Descricao "Cálculo de métricas, estratégias, gestão de risco e execução de ordens." -Ficheiros "metrics.py, strategies.py, risk_manager.py, executor.py" -Configs "MAX_DAILY_DRAWDOWN_PCT e MAX_POSITION_SIZE_PCT configurados no .env."
Criar-LeiaMe -Dir "backend/app/exporter" -Titulo "Exportação de Logs" -Descricao "Geração de relatórios profissionais em múltiplos formatos." -Ficheiros "log_exporter.py" -Configs "Dependências: reportlab (PDF). Geração assíncrona para não bloquear a UI."
Criar-LeiaMe -Dir "backend/app/api" -Titulo "Camada de API" -Descricao "Endpoints REST e validação de dados." -Ficheiros "routes.py, models.py" -Configs "Modelos Pydantic para validação estrita de inputs. CORS configurado para o frontend."
Criar-LeiaMe -Dir "backend/tests" -Titulo "Testes Unitários" -Descricao "Validação automática das estratégias e do gestor de risco." -Ficheiros "test_strategies.py, test_risk_manager.py" -Configs "Executar com 'pytest'. Mock de respostas de exchange para testes isolados."

# --- FRONTEND ---
Criar-LeiaMe -Dir "frontend" -Titulo "Frontend (Next.js)" -Descricao "Interface de utilizador, dashboard e gestão de temas." -Ficheiros "package.json, tailwind.config.js, src/" -Configs "Executar 'npm install' e 'npm run dev'. Tema escuro por defeito."
Criar-LeiaMe -Dir "frontend/src/app" -Titulo "Rotas e Layout" -Descricao "Ponto de entrada da aplicação React, layout global e anti-FOUC." -Ficheiros "layout.tsx, page.tsx" -Configs "Script inline no <head> para prevenir flash de tema claro. ThemeProvider ativo."
Criar-LeiaMe -Dir "frontend/src/components" -Titulo "Componentes UI" -Descricao "Blocos de construção reutilizáveis da interface." -Ficheiros "ThemeToggle.tsx, Dashboard.tsx, KillSwitch.tsx, Footer.tsx" -Configs "Tailwind CSS com cores personalizadas (#0B0E11 para dark, #F5F5F5 para light)."
Criar-LeiaMe -Dir "frontend/src/lib" -Titulo "Bibliotecas e Utilitários" -Descricao "Funções auxiliares e lógica de negócio do lado do cliente." -Ficheiros "theme.ts" -Configs "Lógica de leitura de localStorage e prefers-color-scheme."

# Criar ficheiros base
New-Item -ItemType File -Force -Path ".env.example","docker-compose.yml","README.md","LICENSE" | Out-Null
New-Item -ItemType File -Force -Path "backend/pyproject.toml" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/main.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/core/config.py","backend/app/core/security.py","backend/app/core/scheduler.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/exchanges/adapter.py","backend/app/exchanges/binance_conn.py","backend/app/exchanges/coinbase_conn.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/engine/metrics.py","backend/app/engine/strategies.py","backend/app/engine/risk_manager.py","backend/app/engine/executor.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/exporter/log_exporter.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/app/api/routes.py","backend/app/api/models.py" | Out-Null
New-Item -ItemType File -Force -Path "backend/tests/test_strategies.py","backend/tests/test_risk_manager.py" | Out-Null
New-Item -ItemType File -Force -Path "frontend/package.json","frontend/tailwind.config.js" | Out-Null
New-Item -ItemType File -Force -Path "frontend/src/app/layout.tsx","frontend/src/app/page.tsx" | Out-Null
New-Item -ItemType File -Force -Path "frontend/src/components/ThemeToggle.tsx","frontend/src/components/Dashboard.tsx","frontend/src/components/KillSwitch.tsx","frontend/src/components/Footer.tsx" | Out-Null
New-Item -ItemType File -Force -Path "frontend/src/lib/theme.ts" | Out-Null

Write-Host "Estrutura criada com sucesso em $(Get-Location)!" -ForegroundColor Green