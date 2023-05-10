*** Settings ***
Resource    ../resources/main.robot
Test Setup    Dado que eu acesse o organo
Test Teardown    Fechar o navegador
Test Timeout    2 minutes

*** Test Cases ***
Verificar se ao preencher os campos do formulário corretamente o colaborador é criado corretamente
    Dado que eu preencha os campos do formulário
    Quando clicar no botão criar card
    Então deve criar um card de colaborador com sucesso

Verificar se ao não preencher os campos do formulário e clicar no botão criar card se é exibida mensagem de erro para os campos e card não é criado
    Quando clicar no botão criar card
    Então não deve criar um card de colaborador com sucesso
    E devem ser exibidas mensagens de erro nos campos

Verificar se é possível criar vários cards ao preencher os campos corretamente
    FOR    ${i}    IN RANGE    0    3
        Dado que eu preencha os campos do formulário
        Quando clicar no botão criar card
        Então deve criar um card de colaborador com sucesso
    END

Verificar se é possível criar um card para cada time disponível
        Então criar e identificar um card em cada time disponível
    