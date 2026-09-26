# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

import pytest
from app.engine.risk_manager import RiskManager

def test_drawdown_kill_switch():
    rm = RiskManager(initial_capital=10000.0)
    # Simula queda de 16% (limite é 15%)
    assert rm.check_drawdown_limit(8400.0) is True
    assert rm.is_killed is True
    assert rm.check_kill_switch() is True

def test_position_sizing():
    rm = RiskManager(initial_capital=10000.0)
    # 2% de risco = 200. Com stop loss de 1% (0.01), posição = 200 / (100 * 0.01) = 200
    qty = rm.calculate_position_size(price=100.0, account_balance=10000.0)
    assert qty == 200.0