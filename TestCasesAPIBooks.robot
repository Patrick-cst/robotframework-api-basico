
*** Settings ***

Documentation  Documentation da API:
Resource    ResourcesAPI.robot
Suite Setup    Conectar a minha api



*** Test Cases ***
buscar a listagem de todo os livros (Get em todo os livros)
   Requisitar todos os livros
   Conferir o status code    200
   Conferir o reason    OK
   Conferir lista com 200 livros

Buscar um livro especifico (GET em um livro especifico)  
   Requisitar o livro "15"
   Conferir o status code    200
   Conferir o reason    OK
   Conferir se retorna todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
   Cadastrar um novo livro

Deletar livro
   Requisitar todos os livros
   Deletar livro "10"
