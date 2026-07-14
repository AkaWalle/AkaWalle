# 🚨 SOLUÇÃO IMEDIATA - Variáveis de Ambiente Faltando

## Problema Confirmado

O código JavaScript mostra que a aplicação está falhando porque as seguintes variáveis de ambiente do **Supabase** não estão configuradas na Vercel:

```javascript
// Código que está falhando:
function n(e){
  let r=s.env[e];
  if(!r||""===r.trim())
    throw Error(`Variavel de ambiente ausente: ${e}. 
                 Copie .env.local.example para .env.local 
                 e preencha os valores do Supabase.`);
  return r
}

let l={
  supabaseUrl:n("NEXT_PUBLIC_SUPABASE_URL"),
  supabaseAnonKey:n("NEXT_PUBLIC_SUPABASE_ANON_KEY")
};
```

## ✅ Solução (5 minutos)

### Passo 1: Acessar as configurações do projeto na Vercel

1. Acesse: https://vercel.com
2. Faça login
3. Selecione o projeto **cosmeticos-da-cleo**
4. Clique em **Settings** (Configurações)
5. No menu lateral, clique em **Environment Variables** (Variáveis de Ambiente)

### Passo 2: Adicionar as variáveis do Supabase

Você precisa adicionar 2 variáveis:

#### Variável 1: `NEXT_PUBLIC_SUPABASE_URL`
- **Key (Chave)**: `NEXT_PUBLIC_SUPABASE_URL`
- **Value (Valor)**: URL do seu projeto Supabase (exemplo: `https://xxxxx.supabase.co`)
- **Environment**: Marque todas (Production, Preview, Development)

#### Variável 2: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- **Key (Chave)**: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- **Value (Valor)**: Chave anônima do Supabase (começa com `eyJ...`)
- **Environment**: Marque todas (Production, Preview, Development)

### Passo 3: Onde encontrar esses valores?

Se você já tem um projeto Supabase:

1. Acesse: https://supabase.com/dashboard
2. Selecione seu projeto
3. Clique em **Settings** (ícone de engrenagem)
4. Clique em **API**
5. Na seção **Project URL**, copie a URL
6. Na seção **Project API keys**, copie a **anon/public** key

### Passo 4 (SE NÃO TIVER PROJETO SUPABASE): Criar projeto Supabase

1. Acesse: https://supabase.com/dashboard
2. Clique em **New Project**
3. Preencha:
   - **Name**: cosmeticos-da-cleo
   - **Database Password**: Crie uma senha forte (ANOTE EM LUGAR SEGURO!)
   - **Region**: South America (São Paulo)
4. Clique em **Create new project** e aguarde 1-2 minutos
5. Após criação, vá em **Settings > API** e copie as credenciais

### Passo 5: Fazer redeploy

Após adicionar as variáveis de ambiente na Vercel:

1. Vá para a aba **Deployments**
2. Clique nos 3 pontinhos (...) do último deployment
3. Clique em **Redeploy**
4. Aguarde 1-2 minutos

**OU simplesmente faça um commit vazio no repositório:**

```bash
git commit --allow-empty -m "chore: trigger redeploy com env vars"
git push
```

### Passo 6: Testar

1. Aguarde o deployment completar (verá notificação na Vercel)
2. Acesse: https://cosmeticos-da-cleo.vercel.app/login
3. A página deve carregar normalmente agora!

## 📋 Checklist de Verificação

- [ ] Variável `NEXT_PUBLIC_SUPABASE_URL` adicionada na Vercel
- [ ] Variável `NEXT_PUBLIC_SUPABASE_ANON_KEY` adicionada na Vercel
- [ ] Ambas marcadas para Production
- [ ] Redeploy realizado
- [ ] Página de login carregando

## 🔒 Segurança

### ⚠️ IMPORTANTE - Nunca compartilhe:
- ❌ Database Password
- ❌ Service Role Key (só use no backend!)

### ✅ Seguro para usar no frontend:
- ✅ Project URL
- ✅ Anon/Public Key

A chave "anon" é segura para uso público porque o Supabase usa Row Level Security (RLS) para proteger os dados.

## 🎯 Teste Rápido

Após configurar, você pode testar se as variáveis estão acessíveis:

1. Abra o console do navegador (F12) na página de login
2. Digite: `console.log(process.env.NEXT_PUBLIC_SUPABASE_URL)`
3. Deve mostrar a URL do Supabase (não undefined)

## 📞 Se ainda não funcionar

Verifique no Vercel Dashboard:

1. Vá em **Deployments**
2. Clique no último deployment
3. Clique na aba **Functions** ou **Build Logs**
4. Procure por erros nas variáveis de ambiente

## 🔗 Links Rápidos

- Vercel Dashboard: https://vercel.com
- Supabase Dashboard: https://supabase.com/dashboard
- Documentação Supabase + Next.js: https://supabase.com/docs/guides/getting-started/quickstarts/nextjs

---

**Tempo estimado para correção**: 5-10 minutos
**Complexidade**: Baixa (apenas configuração)
**Impacto**: Resolve 100% do problema
