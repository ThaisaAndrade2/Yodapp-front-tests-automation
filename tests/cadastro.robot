*** Settings ***
Documentation    Suite de testes do cadastro de personagens
Resource         ${EXECDIR}/resources/base.robot

Test Setup       Start Session
Test Teardown    End Session


*** Test Case ***
Deve cadastrar um novo personagem
    [Tags]    happy

    # Dado que acesso o formulário de cadastro
    Click    text=Novo

    #Checkpoint - ponto de verificação para saber se estamos no lugar certo, toda vez que tiver transações de tela é importante utiliza-lo.
    Wait For Elements State    css=.card-header-title >> text=Cadastrar novo usuário
    ...                        visible                                                  5

    # Quando preencho esse formulário com os dados do Mestre Yoda
    Fill Text    css=input[placeholder^="Nome"]    Mestre Yoda2
    Fill Text    css=input[placeholder="Email"]    yoda@jedi.com

    Select Options By    css=.ordem select    text    Jedi

    Click    xpath=//input[@value="Cavaleiro Jedi"]/..//span[@class="check"]

    Select Birth Date    fevereiro-1999-22

    Fill Text    id=insta                                                        @yoda
    Click        xpath=//input[@name="comunications"]/../span[@class="check"]

    # E submeto esse formulário
    Click    css=button >> text=Cadastrar

    # Então devo ver a mensagem de sucesso

    #Sleep        1
    #${html}        Get Page Source
    #Log            ${html}
    Wait For Elements State    css=.toast div >> text=Usuário cadastrado com sucesso!
    ...                        visible                                                   5


Email incorreto
    [Tags]    inv_email
    # Dado que acesso o formulário de cadastro
    Click     text=Novo

    #Checkpoint - ponto de verificação para saber se estamos no lugar certo, toda vez que tiver transações de tela é importante utiliza-lo.
    Wait For Elements State    css=.card-header-title >> text=Cadastrar novo usuário
    ...                        visible                                                  5

    # Quando preencho esse formulário com email incorreto
    Fill Text    css=input[placeholder^="Nome"]    Darth Vader
    Fill Text    css=input[placeholder="Email"]    vader&hotmail.com

    Select Options By    css=.ordem select    text    Sith

    Select Birth Date    fevereiro-2001-8

    Fill Text    id=insta                                                        @vader
    Click        xpath=//input[@name="comunications"]/../span[@class="check"]

    # E submeto esse formulário
    Click    css=button >> text=Cadastrar

    # Então devo ver a mensagem de erro

    Wait For Elements State    css=.toast div >> text=Oops! O email é incorreto.
    ...                        visible                                              5


*** Keywords ***
Select Birth Date
    [Arguments]    ${text_date}

    @{date}    Split String    ${text_date}    -

    Click    css=input[placeholder="Data de nascimento"]

    Select Options By    xpath=(//header[@class="datepicker-header"]//select)[1]
    ...                  text                                                       ${date}[0]

    Select Options By    xpath=(//header[@class="datepicker-header"]//select)[2]
    ...                  value                                                      ${date}[1]

    Click    xpath=//a[contains(@class, "datepicker-cell")]//span[text()="${date}[2]"]