*** Settings ***
Resource    ../main.robot

*** Variables ***
${URL}                    http://localhost:3000/
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
@{Selecionar_times}
...    //option[contains(.,'Programação')]
...    //option[contains(.,'Front-End')]
...    //option[contains(.,'Data Science')]
...    //option[contains(.,'Devops')] 
...    //option[contains(.,'UX e Design')]
...    //option[contains(.,'Mobile')]
...    //option[contains(.,'Inovação e Gestão')]
${COLABORADOR}            class:colaborador
${ERRO_NOME}              id:form-nome-erro
${ERRO_CARGO}             id:form-cargo-erro
${ERRO_TIME}              id:form-times-erro

*** Keywords ***
Dado que eu preencha os campos do formulário
    ${Nome}    FakerLibrary.First Name
    Input Text    ${CAMPO_NOME}    ${Nome}
    ${Cargo}    FakerLibrary.Job
    Input Text    ${CAMPO_CARGO}    ${Cargo}
    ${Image}    FakerLibrary.Image Url  width=200  height=200
    Input Text    ${CAMPO_IMAGEM}    ${Image}
    Click Element   ${CAMPO_TIME}
    Click Element   ${Selecionar_times}[0]
Quando clicar no botão criar card
    Click Button    ${BOTAO_CARD}
Então deve criar um card de colaborador com sucesso
    Element Should Be Visible    ${COLABORADOR} 
#    Sleep    3
Então não deve criar um card de colaborador com sucesso
    Element Should Not Be Visible    ${COLABORADOR}
E devem ser exibidas mensagens de erro nos campos
    Element Should Be Visible    ${ERRO_NOME}
    Element Text Should Be    ${ERRO_NOME}    O campo nome deve ser preenchido
    Element Should Be Visible    ${ERRO_CARGO}
    Element Text Should Be    ${ERRO_CARGO}    O campo cargo deve ser preenchido
    Element Should Be Visible    ${ERRO_TIME}
    Element Text Should Be    ${ERRO_TIME}    Selecione um time para essa pessoa
Então criar e identificar um card em cada time disponível
    FOR    ${i}    ${time}    IN ENUMERATE    @{Selecionar_times}
        Dado que eu preencha os campos do formulário
        Click Element    ${time} 
        Quando clicar no botão criar card 
    END
#    Sleep    10