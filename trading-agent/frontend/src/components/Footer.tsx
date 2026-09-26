// Copyright © Luís Garcês — Todos os direitos reservados
// Contacto: 915 020 614 | activecop@gmail.com

export default function Footer() {
  return (
    <footer className="fixed bottom-0 w-full bg-[#F5F5F5] dark:bg-[#1E2329] border-t border-gray-200 dark:border-gray-800 p-4 text-center text-sm transition-colors duration-200">
      <p className="font-semibold">
        Copyright © Luís Garcês — Todos os direitos reservados
      </p>
      <p className="text-gray-600 dark:text-gray-400">
        Contacto: 915 020 614 | activecop@gmail.com
      </p>
      <p className="text-xs text-red-500 mt-2">
        Disclaimer: Trading envolve risco de perda total do capital. Este sistema não constitui aconselhamento financeiro.
      </p>
    </footer>
  );
}