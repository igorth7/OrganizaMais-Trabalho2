# Organiza+ — Trabalho 2 (MAF)

Aplicativo Android desenvolvido em **Kotlin** com **Jetpack Compose**, **Material 3** e **Navigation Compose**. O projeto demonstra navegação entre telas, duas coleções reativas, inclusão, edição, conclusão, remoção de itens, detalhes por identificador e indicadores calculados a partir dos dados reais.

## Requisitos

- Android Studio com suporte a Android Gradle Plugin 8.7.3
- JDK 17 ou superior compatível com o Android Studio
- Android SDK Platform 35
- Dispositivo ou emulador com Android 7.0 (API 24) ou superior
- Conexão com a internet na primeira sincronização para baixar as dependências

## Como executar

1. Abra a pasta `OrganizaMais` no Android Studio.
2. No macOS/Linux, antes da primeira sincronização, rode `./gradlew --version` no terminal da pasta para obter o arquivo oficial do Gradle Wrapper. No Windows, execute `gradlew.bat --version`.
3. Aguarde a sincronização do Gradle e a instalação das dependências.
4. Selecione o módulo `app` e um emulador ou dispositivo Android.
5. Clique em **Run** para iniciar o aplicativo.

Os arquivos `gradlew` e `gradlew.bat` fazem o download do `gradle-wrapper.jar` oficial na primeira execução, porque o ambiente usado na preparação do projeto não tinha conectividade para incluí-lo no pacote. Caso o primeiro acesso falhe, verifique a conexão com o servidor de distribuições do Gradle ou gere um wrapper local com Gradle 8.9.

## Oito telas

| Tela | Rota | Função |
| --- | --- | --- |
| Início | `inicio` | Visão geral e acesso às áreas |
| Tarefas | `tarefas` | Lista reativa, cadastro, conclusão e remoção |
| Projetos | `projetos` | Lista reativa, cadastro e remoção |
| Resumo | `resumo` | Indicadores atualizados em tempo real |
| Detalhes da tarefa | `tarefa/{id}` | Dados da tarefa, edição, conclusão e link para projeto |
| Detalhes do projeto | `projeto/{id}` | Dados, edição, progresso calculado e tarefas relacionadas |
| Ajuda | `ajuda` | Guia de utilização |
| Sobre | `sobre` | Informações técnicas do aplicativo |

As quatro áreas principais são acessadas pela `NavigationBar`. As demais utilizam a navegação por rotas e o botão de voltar da `TopAppBar`.

## Estrutura

```text
app/src/main/java/br/edu/organizamais/
├── MainActivity.kt
├── model/
│   ├── Models.kt
│   └── OrganizaState.kt
├── navigation/
│   ├── Routes.kt
│   └── AppNavigation.kt
└── ui/
    ├── components/Components.kt
    ├── screens/
    │   ├── InicioScreen.kt
    │   ├── TarefasScreen.kt
    │   ├── ProjetosScreen.kt
    │   ├── TarefaDetalheScreen.kt
    │   ├── ProjetoDetalheScreen.kt
    │   ├── ResumoScreen.kt
    │   ├── AjudaScreen.kt
    │   └── SobreScreen.kt
    └── theme/Theme.kt
```

## Tecnologias

- Kotlin 2.0.21
- Android Gradle Plugin 8.7.3
- Gradle 8.9
- Jetpack Compose BOM 2024.12.01
- Navigation Compose 2.8.5
- Material Design 3

## Dados e comportamento

`Projeto` e `Tarefa` são classes de dados distintas. As duas coleções usam `mutableStateListOf`, permitindo que a UI reflita alterações imediatamente. Os IDs são incrementais e são enviados nas rotas de detalhes. O item correto é consultado pela ID; nenhum detalhe é preenchido com valores estáticos.

Ao remover um projeto, as tarefas associadas não são apagadas: elas passam a constar como **Sem projeto**. O detalhe de projeto calcula a quantidade de tarefas vinculadas e o percentual concluído; a tela Resumo acompanha essas informações automaticamente.

A persistência fora da memória não foi implementada, conforme a seção 5 do enunciado. Ao encerrar o processo do aplicativo, os dados voltam ao estado inicial de demonstração.

## Testes

Para executar os testes de lógica com Gradle:

```bash
./gradlew :app:testDebugUnitTest
```

Há testes para cadastro, validação, conclusão, edição e relacionamento entre projetos e tarefas. Para comprovar o funcionamento da interface, execute o roteiro em `docs/ROTEIRO_DE_TESTES.md` em um dispositivo ou emulador.

## Documentação e evidências

- `docs/PROCESSO_E_DECISOES.md`: arquitetura, implementação e decisões técnicas
- `docs/ROTEIRO_DE_TESTES.md`: procedimentos de verificação
- `docs/REGISTRO_DE_EVIDENCIAS.md`: capturas exigidas pelo enunciado
- `prints/`: local para adicionar capturas reais do app executando

**Atenção:** o enunciado exige a continuidade das três telas entregues no Trabalho 1. Como os arquivos desse trabalho anterior não foram fornecidos, este repositório contém uma implementação independente com três telas principais equivalentes (Início, Tarefas e Projetos) e cinco telas adicionais. Antes de enviar como continuação, confronte-o com a entrega anterior e adapte o tema e as telas, caso sejam diferentes.

## Entrega

Crie um **novo repositório** no GitHub, publique os arquivos desta pasta, registre as decisões e inclua capturas reais em `prints/`. Apresente o aplicativo em funcionamento adicionando/removendo itens nas duas listas, abrindo detalhes correspondentes e navegando pela barra inferior.
