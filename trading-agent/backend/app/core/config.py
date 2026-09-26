# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

from pydantic_settings import BaseSettings
from cryptography.fernet import Fernet
import os

class Settings(BaseSettings):
    PROJECT_NAME: str = "Agente de Trading Autónomo"
    VERSION: str = "1.0.0"
    AUTHOR: str = "Luís Garcês"
    CONTACT_EMAIL: str = "activecop@gmail.com"
    CONTACT_PHONE: str = "915 020 614"
    COPYRIGHT: str = "© Luís Garcês — Todos os direitos reservados"
    
    TRADING_MODE: str = "PAPER"  # PAPER ou LIVE
    FERNET_KEY: str
    
    MAX_DAILY_DRAWDOWN_PCT: float = 15.0
    MAX_POSITION_SIZE_PCT: float = 2.0

    class Config:
        env_file = ".env"

settings = Settings()
cipher_suite = Fernet(settings.FERNET_KEY.encode())