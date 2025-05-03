# 🔄 Azure VM Start/Stop via Tag – PowerShell Runbook

Este projeto fornece um **runbook PowerShell** para **ligar ou desligar máquinas virtuais no Azure com base em uma tag personalizada**, ideal para automação via **Azure Automation Account** com Managed Identity.

## 📌 Visão Geral

Automatize a gestão de VMs com base em tags como `AutoShutdown = true`, otimizando custos em ambientes de desenvolvimento, homologação e laboratórios.

---

## ⚙️ Funcionalidades

- ✅ Executa Start ou Stop de VMs com base em uma tag
- 🔐 Usa **Managed Identity** para autenticação segura
- 🕒 Suporte a **agendamento automático** via Azure Automation
- 🌐 Compatível com múltiplas subscriptions e regiões

---

## 🛠️ Pré-requisitos

- Azure Automation Account com Managed Identity habilitada
- Permissões da identidade gerenciada: `Contributor` nas VMs ou no Resource Group
- Azure PowerShell Modules importados: `Az.Accounts`, `Az.Compute`, `Az.Resources`

---

## ▶️ Parâmetros do Script



| Parâmetro   | Obrigatório | Valores possíveis | Descrição |
|-------------|-------------|-------------------|-----------|
| `Action`    | Sim         | `Start`, `Stop`   | Ação a ser executada |
| `TagName`   | Não         | Qualquer string   | Nome da tag a ser verificada (padrão: `AutoShutdown`) |
| `TagValue`  | Não         | Qualquer string   | Valor esperado da tag (padrão: `true`) |

---

## 💡 Exemplo de Uso

```powershell
# Executar via Runbook para parar VMs com AutoShutdown = true
.\Runbook.ps1 -Action Stop

# Para iniciar VMs com uma tag customizada
.\Runbook.ps1 -Action Start -TagName "AutoStart" -TagValue "yes"

🧾 Saída esperada

Total de VMs encontradas com a tag 'AutoShutdown=true': 3
Parando VM: vm-dev-01
Parando VM: vm-test-02
...

🛡️ Segurança
O script autentica usando Connect-AzAccount -Identity, garantindo que as credenciais não estejam embutidas no código.

A identidade gerenciada deve ter permissão suficiente para operar as VMs.

📄 Licença
Este projeto está licenciado sob os termos da MIT License.

Desenvolvido pela comunidade e compartilhado por Erick Medeiros
LinkedIn: [@erickbmedeiros](https://www.linkedin.com/in/erickbmedeiros/)

