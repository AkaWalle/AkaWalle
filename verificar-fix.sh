#!/bin/bash

# Script de Verificação - Cosméticos da Cleo
# Verifica se o problema de login foi corrigido

echo "🔍 Verificando o status da aplicação..."
echo ""

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Verificar se a página responde
echo "1️⃣  Verificando conectividade..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://cosmeticos-da-cleo.vercel.app/login)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo -e "${GREEN}✓${NC} Página respondendo (HTTP $HTTP_STATUS)"
else
    echo -e "${RED}✗${NC} Página com problema (HTTP $HTTP_STATUS)"
fi

# 2. Verificar se ainda há erro de bailout
echo ""
echo "2️⃣  Verificando erro de renderização..."
BAILOUT=$(curl -s https://cosmeticos-da-cleo.vercel.app/login | grep -c "BAILOUT_TO_CLIENT_SIDE_RENDERING")

if [ "$BAILOUT" -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Sem erros de bailout detectados"
else
    echo -e "${RED}✗${NC} Ainda há erro de bailout ($BAILOUT ocorrências)"
fi

# 3. Verificar tamanho do HTML (deve ser maior se funcionando)
echo ""
echo "3️⃣  Verificando conteúdo da página..."
HTML_SIZE=$(curl -s https://cosmeticos-da-cleo.vercel.app/login | wc -c)

if [ "$HTML_SIZE" -gt 10000 ]; then
    echo -e "${GREEN}✓${NC} Página com conteúdo adequado (${HTML_SIZE} bytes)"
else
    echo -e "${YELLOW}⚠${NC}  Página pequena, possível problema (${HTML_SIZE} bytes)"
fi

# 4. Verificar se tem formulário de login
echo ""
echo "4️⃣  Verificando formulário de login..."
LOGIN_FORM=$(curl -s https://cosmeticos-da-cleo.vercel.app/login | grep -c "type=\"email\"")

if [ "$LOGIN_FORM" -gt 0 ]; then
    echo -e "${GREEN}✓${NC} Formulário de login encontrado"
else
    echo -e "${RED}✗${NC} Formulário de login não encontrado"
fi

# 5. Verificar headers importantes
echo ""
echo "5️⃣  Verificando headers da aplicação..."
HEADERS=$(curl -s -I https://cosmeticos-da-cleo.vercel.app/login)

if echo "$HEADERS" | grep -q "x-nextjs-prerender"; then
    echo -e "${GREEN}✓${NC} Next.js configurado corretamente"
else
    echo -e "${YELLOW}⚠${NC}  Headers do Next.js não encontrados"
fi

if echo "$HEADERS" | grep -q "x-vercel-id"; then
    echo -e "${GREEN}✓${NC} Deploy na Vercel confirmado"
else
    echo -e "${YELLOW}⚠${NC}  Deploy da Vercel não confirmado"
fi

# Resumo
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 RESUMO DA VERIFICAÇÃO"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

TOTAL_CHECKS=5
PASSED_CHECKS=0

[ "$HTTP_STATUS" -eq 200 ] && ((PASSED_CHECKS++))
[ "$BAILOUT" -eq 0 ] && ((PASSED_CHECKS++))
[ "$HTML_SIZE" -gt 10000 ] && ((PASSED_CHECKS++))
[ "$LOGIN_FORM" -gt 0 ] && ((PASSED_CHECKS++))
echo "$HEADERS" | grep -q "x-vercel-id" && ((PASSED_CHECKS++))

echo ""
echo "Verificações passadas: $PASSED_CHECKS/$TOTAL_CHECKS"
echo ""

if [ "$PASSED_CHECKS" -eq "$TOTAL_CHECKS" ]; then
    echo -e "${GREEN}✓ TUDO OK!${NC} A aplicação está funcionando corretamente."
    echo ""
    echo "🎉 Você pode acessar: https://cosmeticos-da-cleo.vercel.app/login"
elif [ "$PASSED_CHECKS" -ge 3 ]; then
    echo -e "${YELLOW}⚠ PARCIALMENTE OK${NC} - A aplicação está respondendo mas pode ter problemas."
    echo ""
    echo "📝 Sugestões:"
    echo "  1. Limpe o cache do navegador"
    echo "  2. Teste em modo anônimo/privado"
    echo "  3. Verifique o console do navegador (F12)"
else
    echo -e "${RED}✗ PROBLEMA DETECTADO${NC} - A aplicação ainda não está funcionando."
    echo ""
    echo "📝 Próximos passos:"
    echo "  1. Verifique se as variáveis de ambiente foram adicionadas na Vercel"
    echo "  2. Confirme que fez o redeploy após adicionar as variáveis"
    echo "  3. Aguarde 2-3 minutos após o deploy"
    echo "  4. Verifique os logs no Vercel Dashboard"
    echo ""
    echo "📖 Leia o arquivo SOLUCAO_IMEDIATA.md para mais detalhes"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Informações adicionais
echo "ℹ️  Informações adicionais:"
echo "  • Última verificação: $(date)"
echo "  • URL testada: https://cosmeticos-da-cleo.vercel.app/login"
echo "  • Tamanho do HTML: ${HTML_SIZE} bytes"
echo ""

# Oferecer testar no navegador
echo "💡 Dica: Para testar no navegador, execute:"
echo "  open https://cosmeticos-da-cleo.vercel.app/login"
echo "  ou"
echo "  xdg-open https://cosmeticos-da-cleo.vercel.app/login"
echo ""
