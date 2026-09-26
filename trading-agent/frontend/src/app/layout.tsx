// Copyright © Luís Garcês — Todos os direitos reservados
// Contacto: 915 020 614 | activecop@gmail.com

import './globals.css';
import { ThemeProvider } from 'next-themes';

// Script inline para aplicar o tema ANTES do paint, evitando flash de tema errado
const themeScript = `
  (function() {
    const storedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const initialTheme = storedTheme || 'dark'; // Dark é o default explícito
    document.documentElement.classList.add(initialTheme);
  })();
`;

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-PT" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: themeScript }} />
      </head>
      <body className="bg-white dark:bg-[#0B0E11] text-[#1E2329] dark:text-[#EAECEF] transition-colors duration-200">
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem={false}>
          {children}
        </ThemeProvider>
      </body>
    </html>
  );
}