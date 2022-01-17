*** Settings ***
Documentation        Aqui não é suite, mas o arquivo principal do projeto
Library              Browser

*** Keywords ***
Start Session
    New Browser        chromium        headless=False        slowMo=00:00:01
    New Page        https://yodapp.vercel.app

End Session
    Take Screenshot