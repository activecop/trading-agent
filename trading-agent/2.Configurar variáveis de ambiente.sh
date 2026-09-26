cp .env.example .env
# Gera uma chave Fernet: python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
# Edita o .env com as tuas chaves API (permissões APENAS "Read" e "Trade", NUNCA "Withdraw")