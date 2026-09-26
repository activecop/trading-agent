#!/bin/bash
# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

echo "A iniciar a criação da estrutura do Agente de Trading Autónomo..."

# Criar diretórios
mkdir -p trading-agent/backend/app/{core,exchanges,engine,exporter,api}
mkdir -p trading-agent/backend/tests
mkdir -p trading-agent/frontend/src/{app,components,lib}

cd trading-agent || exit

# Função para criar ficheiros leia-me.txt
criar_leia_me() {
    local dir=$1
    local titulo=$2
    local descricao=$3
    local ficheiros=$4
    local configs=$5

    cat << EOF > "$dir/leia-me.txt"
================================================================================
Copyright © Luís Garcês — Todos os direitos reservados
Contacto: 915 020 614 | activecop@gmail.com
================================================================================

DIRETÓRIA: $titulo
--------------------------------------------------------------------------------
DESCRIÇÃO:
$descricao

FICHEIROS ESPERADOS:
$ficheiros

CONFIGURAÇÕES APLICÁVEIS:
$configs
================================================================================
EOF
}

# --- ROOT ---
criar_leia_me "." "Raiz do Projeto" "Ponto de entrada do monorepo. Contém orquestração, documentação e variáveis de ambiente." ".env.example, docker-compose.yml, README.md, LICENSE" "Definir TRADING_MODE=PAPER, gerar FERNET_KEY, configurar DATABASE_URL."

# --- BACKEND ---
criar_leia_me "backend" "Backend (Python/FastAPI)" "Lógica principal do servidor, motores de trading e API." "pyproject.toml, app/, tests/" "Instalar dependências via 'uv pip install' ou 'poetry install'."

criar_leia_me "backend/app/core" "Núcleo do Backend" "Gestão de configurações, segurança e agendamento de tarefas." "config.py, security.py, scheduler.py" "Variáveis de ambiente carregadas via pydantic-settings. Chaves de API cifradas com Fernet."

criar_leia_me "backend/app/exchanges" "Conectores de Exchange" "Adaptadores para comunicação com Binance e Coinbase." "adapter.py, binance_conn.py, coinbase_conn.py" "Chaves API no .env com permissões APENAS 'Read' e 'Trade'. Rate limiting ativo."

criar_leia_me "backend/app/engine" "Motor de Trading" "Cálculo de métricas, estratégias, gestão de risco e execução de ordens." "metrics.py, strategies.py, risk_manager.py, executor.py" "MAX_DAILY_DRAWDOWN_PCT e MAX_POSITION_SIZE_PCT configurados no .env."

criar_leia_me "backend/app/exporter" "Exportação de Logs" "Geração de relatórios profissionais em múltiplos formatos." "log_exporter.py" "Dependências: reportlab (PDF). Geração assíncrona para não bloquear a UI."

criar_leia_me "backend/app/api" "Camada de API" "Endpoints REST e validação de dados." "routes.py, models.py" "Modelos Pydantic para validação estrita de inputs. CORS configurado para o frontend."

criar_leia_me "backend/tests" "Testes Unitários" "Validação automática das estratégias e do gestor de risco." "test_strategies.py, test_risk_manager.py" "Executar com 'pytest'. Mock de respostas de exchange para testes isolados."

# --- FRONTEND ---
criar_leia_me "frontend" "Frontend (Next.js)" "Interface de utilizador, dashboard e gestão de temas." "package.json, tailwind.config.js, src/" "Executar 'npm install' e 'npm run dev'. Tema escuro por defeito."

criar_leia_me "frontend/src/app" "Rotas e Layout" "Ponto de entrada da aplicação React, layout global e anti-FOUC." "layout.tsx, page.tsx" "Script inline no <head> para prevenir flash de tema claro. ThemeProvider ativo."

criar_leia_me "frontend/src/components" "Componentes UI" "Blocos de construção reutilizáveis da interface." "ThemeToggle.tsx, Dashboard.tsx, KillSwitch.tsx, Footer.tsx" "Tailwind CSS com cores personalizadas (#0B0E11 para dark, #F5F5F5 para light)."

criar_leia_me "frontend/src/lib" "Bibliotecas e Utilitários" "Funções auxiliares e lógica de negócio do lado do cliente." "theme.ts" "Lógica de leitura de localStorage e prefers-color-scheme."

# Criar ficheiros base vazios (ou com conteúdo mínimo)
touch .env.example docker-compose.yml README.md LICENSE
touch backend/pyproject.toml
touch backend/app/main.py
touch backend/app/core/{config,security,scheduler}.py
touch backend/app/exchanges/{adapter,binance_conn,coinbase_conn}.py
touch backend/app/engine/{metrics,strategies,risk_manager,executor}.py
touch backend/app/exporter/log_exporter.py
touch backend/app/api/{routes,models}.py
touch backend/tests/{test_strategies,test_risk_manager}.py
touch frontend/package.json frontend/tailwind.config.js
touch frontend/src/app/{layout,page}.tsx
touch frontend/src/components/{ThemeToggle,Dashboard,KillSwitch,Footer}.tsx
touch frontend/src/lib/theme.ts

echo "Estrutura criada com sucesso em $(pwd)!"