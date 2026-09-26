# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

class RiskManager:
    def __init__(self, initial_capital: float):
        self.initial_capital = initial_capital
        self.current_capital = initial_capital
        self.daily_peak = initial_capital
        self.is_killed = False  # Kill switch

    def check_kill_switch(self) -> bool:
        """RISCO FINANCEIRO: Se ativado, bloqueia TODAS as ordens imediatamente."""
        if self.is_killed:
            logger.warning("KILL SWITCH ATIVADO. Nenhuma ordem será executada.")
            return True
        return False

    def check_drawdown_limit(self, current_equity: float) -> bool:
        """RISCO FINANCEIRO: Pausa automática se o drawdown diário exceder o limite."""
        self.daily_peak = max(self.daily_peak, current_equity)
        drawdown_pct = ((self.daily_peak - current_equity) / self.daily_peak) * 100
        
        if drawdown_pct >= settings.MAX_DAILY_DRAWDOWN_PCT:
            logger.critical(f"MAX DRAWDOWN ATINGIDO: {drawdown_pct:.2f}%. A pausar trading.")
            self.is_killed = True
            return True
        return False

    def calculate_position_size(self, price: float, account_balance: float) -> float:
        """Calcula o tamanho da posição com base no risco máximo por trade (1-2%)."""
        max_risk_amount = account_balance * (settings.MAX_POSITION_SIZE_PCT / 100)
        # Simplificação: assume stop loss de 1% para cálculo de quantidade
        stop_loss_pct = 0.01 
        quantity = max_risk_amount / (price * stop_loss_pct)
        return round(quantity, 8)