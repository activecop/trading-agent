# Copyright © Luís Garcês — Todos os direitos reservados
# Contacto: 915 020 614 | activecop@gmail.com

import csv
import json
from datetime import datetime
from typing import List, Dict, Any
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib import colors

class LogExporter:
    HEADER_TEXT = "RELATÓRIO DE ATIVIDADE — AGENTE DE TRADING AUTÓNOMO\n" + "="*58 + "\n" \
                  "Copyright © Luís Garcês — Todos os direitos reservados\n" \
                  "Contacto: 915 020 614 | activecop@gmail.com\n\n"
    
    FOOTER_TEXT = "\nGerado automaticamente em {timestamp} UTC\n" \
                  "© Luís Garcês | 915 020 614 | activecop@gmail.com\n" \
                  "Disclaimer: trading envolve risco de perda total do capital. Este relatório não constitui aconselhamento financeiro."

    def __init__(self, trades: List[Dict[str, Any]], mode: str, metrics: Dict[str, Any]):
        self.trades = trades
        self.mode = mode
        self.metrics = metrics
        self.timestamp = datetime.utcnow().strftime("%Y%m%d_%H%M")

    def export_csv(self) -> str:
        filename = f"agentlog_{self.timestamp}_{self.mode.lower()}.csv"
        with open(filename, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=self.trades[0].keys() if self.trades else [])
            writer.writeheader()
            writer.writerows(self.trades)
        return filename

    def export_json(self) -> str:
        filename = f"agentlog_{self.timestamp}_{self.mode.lower()}.json"
        data = {"metadata": self.metrics, "trades": self.trades, "copyright": "© Luís Garcês"}
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4)
        return filename

    def export_pdf(self) -> str:
        filename = f"agentlog_{self.timestamp}_{self.mode.lower()}.pdf"
        c = canvas.Canvas(filename, pagesize=A4)
        width, height = A4
        
        # Cabeçalho
        c.setFont("Helvetica-Bold", 12)
        c.drawString(40, height - 40, self.HEADER_TEXT.replace('\n', ' | '))
        
        # Watermark discreto
        c.saveState()
        c.setFillAlpha(0.1)
        c.setFont("Helvetica-Bold", 40)
        c.rotate(45)
        c.drawString(100, 100, "© Luís Garcês")
        c.restoreState()

        # Conteúdo (simplificado para exemplo)
        c.setFont("Helvetica", 10)
        y_pos = height - 80
        c.drawString(40, y_pos, f"Período: {self.metrics.get('start_date')} → {self.metrics.get('end_date')}")
        y_pos -= 20
        c.drawString(40, y_pos, f"Modo: {self.mode} | PnL: {self.metrics.get('pnl_pct')}% | Sharpe: {self.metrics.get('sharpe')}")
        
        # Rodapé
        c.setFont("Helvetica-Oblique", 8)
        c.drawString(40, 30, self.FOOTER_TEXT.format(timestamp=datetime.utcnow().isoformat()))
        
        c.save()
        return filename