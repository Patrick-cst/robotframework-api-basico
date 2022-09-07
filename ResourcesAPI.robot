*** Settings ***

Documentation   Documentation da API:
Library       RequestsLibrary
Library       Collections


*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}     id=15
...            title=Book 15
...            pageCount=1500


*** Keywords ***
# SETUP E TEARDOWNS
Conectar a minha api
    Create Session   fakeAPI  ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}    GET On Session    fakeAPI    Books
    log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA} 

Cadastrar um novo livro
     ${HEADERS}     Create Dictionary    content-type=application/json
     ${RESPOSTA}    Post Request    fakeAPI    Books
...      data={"id": 0,"title": "teste","description": "test2","pageCount": 200,"excerpt": "test3","publishDate": "2022-09-06T19:41:04.07Z"}
...      headers=${HEADERS}
    log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA} 

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET On Session    fakeAPI    Books/${ID_LIVRO}
    log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA} 
Conferir o status code
    [Arguments]    ${STATUSCODE_DESEJADO}   
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO} 

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}  
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}  
      
Conferir lista com ${QTDE_LIVROS} livros
    Length Should Be    ${RESPOSTA.json()}    ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id    ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount    ${BOOK_15.pageCount}
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}