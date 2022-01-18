*** Settings ***
Documentation    Suite de testes do cadastro de personagens
Resource         base.robot

Test Setup       Start Session
Test Teardown    End Session


*** Test Case ***
Deve cadastrar um novo personagem
    Click    text=Novo

    #Checkpoint - ponto de verificação para saber se estamos no lugar certo, toda vez que tiver transações de tela é importante utiliza-lo.
    Wait For Elements State    css=.card-header-title >> text=Cadastrar novo usuário
    ...                        visible                                                  5

    Fill Text    css=input[placeholder^="Nome"]    Mestre Yoda2
    Fill Text    css=input[placeholder="Email"]    yoda@jedi.com

    Select Options By    css=.ordem select    text    Jedi

    Click            xpath=//input[@value="Cavaleiro Jedi"]/..//span[@class="check"]

    Select Birth Date    fevereiro    1999    22

    Fill Text    id=insta                          @yoda
    Click            xpath=//input[@name="comunications"]/../span[@class="check"]

    Click        css=button >> text=Cadastrar

    #Temporario
    Sleep    10

*** Keywords ***
Select Birth Date
    [Arguments]    ${month}    ${year}    ${day}

    Click    css=input[placeholder="Data de nascimento"]

    Select Options By    xpath=(//header[@class="datepicker-header"]//select)[1]
    ...                  text                                                       ${month}

    Select Options By    xpath=(//header[@class="datepicker-header"]//select)[2]
    ...                  value                                                      ${year}

    Click    xpath=//a[contains(@class, "datepicker-cell")]//span[text()="${day}"]