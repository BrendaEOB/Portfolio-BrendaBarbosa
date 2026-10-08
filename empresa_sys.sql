create database empresa_sys;
use empresa_sys;

create table departamentos (
id_depto int primary key,
nome_depto varchar(100) not null
);

create table funcionarios (
id_func int primary key,
 nome_func varchar(100) not null,
 cargo varchar(50) not null,
 salario decimal(10,2) not null,
 id_depto int,
 foreign key (id_depto) references departamentos (id_deptos)
 );
 
 create table projetos (
 id_projeto int primary key,
 nome_projeto varchar(100) not null,
 id_depto_responsavel int ,
 orcamento decimal(12,2),
 foreign key (id_depto_responsavel) references departamentos(id_depto)
 );
 
 create table Alocacoes (
 id_func int,
 id_projeto int,
 horas_semanais int,
 primary key (id_func, id_projeto), 
 foreign key (id_func) references funcionarios(id_func), 
 foreign key (id_projeto) references projetos(id_projeto)
 );
 
 insert into departamentos (id_depto, nome_depto) values 
 (1, 'TI'),
 (2, 'Marketing'),
 (3, 'Financeiros'),
 (4, 'Engenharia');
 
 INSERT INTO Funcionarios (id_func, nome_func, cargo, salario, id_depto)
VALUES
(101, 'Ana Silva', 'Desenvolvedora Senior', 9500.00, 1),
(102, 'Carlos Souza', 'Analista de Infraestrutura', 6200.00, 1),
(103, 'Beatriz Lima', 'Especialista de SEO', 5800.00, 2),
(104, 'Daniel Costa', 'Gerente Financeiro', 12000.00, 3),
(105, 'Eduardo Mendes', 'Engenheiro de Dados', 8900.00, 4),
(106, 'Fernanda Rocha', 'Designer UI/UX', 6500.00, 2);
 
 INSERT INTO Projetos (id_projeto, nome_projeto, id_depto_responsavel,
orcamento) VALUES
(201, 'Migração para Nuvem', 1, 150000.00),
(202, 'Campanha Black Friday', 2, 80000.00),
(203, 'Auditoria Anual', 3, 20000.00),
(204, 'Novo Aplicativo Mobile', 4, 250000.00);

INSERT INTO Alocacoes (id_func, id_projeto, horas_semanais) VALUES
(101, 201, 20), (101, 204, 20), (102, 201, 40),
(103, 202, 30), (103, 204, 10), (105, 204, 30),
(106, 202, 20), (106, 204, 20);

/*Crie um relatório listando o nome e o cargo de todos os funcionários, juntamente
com o nome do departamento exato onde cada um deles está lotado. Utilize o nome
completo das tabelas em todo o código, sem usar abreviações.*/

SELECT
Funcionarios.nome_func,
Funcionarios.cargo,
Departamentos.nome_depto
FROM Funcionarios
INNER JOIN Departamentos ON Funcionarios.id_depto = Departamentos.id_depto;

/*A diretoria precisa cruzar dados de RH e Projetos. Faça uma consulta que retorne o
nome do projeto, seu orçamento, o nome do funcionário alocado, o cargo e as
horas semanais trabalhadas. O relatório deve filtrar e exibir apenas projetos com
orçamento superior a 100.000 e funcionários que recebam salário acima de 7.000.*/

SELECT
Projetos.nome_projeto,
Projetos.orcamento,
Funcionarios.nome_func,
Funcionarios.cargo,
Alocacoes.horas_semanais
FROM Projetos
INNER JOIN Alocacoes ON Projetos.id_projeto = Alocacoes.id_projeto
INNER JOIN Funcionarios ON Alocacoes.id_func = Funcionarios.id_func
WHERE Projetos.orcamento > 100000.00
AND Funcionarios.salario > 7000.00;

/*O setor de RH precisa identificar quais colaboradores estão 'emprestados' para
outros setores. Elabore uma consulta que traga: o nome do funcionário, o nome do
seu departamento de origem, o nome do projeto em que ele atua e o nome do
departamento responsável pelo projeto. Aplique um filtro para mostrar
exclusivamente as situações onde o departamento do funcionário seja diferente do
departamento dono do projeto.*/

SELECT
Funcionarios.nome_func,
Depto_Funcionario.nome_depto,
Projetos.nome_projeto,
Depto_Projeto.nome_depto
FROM Funcionarios
INNER JOIN Departamentos AS Depto_Funcionario ON Funcionarios.id_depto =
Depto_Funcionario.id_depto
INNER JOIN Alocacoes ON Funcionarios.id_func = Alocacoes.id_func
INNER JOIN Projetos ON Alocacoes.id_projeto = Projetos.id_projeto
INNER JOIN Departamentos AS Depto_Projeto ON Projetos.id_depto_responsavel
= Depto_Projeto.id_depto
WHERE Funcionarios.id_depto <> Projetos.id_depto_responsavel;

/*Obrigatória (Pegadinha): Aqui entra o momento ideal para testar a atenção da
turma. Neste exercício, usamos a tabela Departamentos duas vezes. Se o aluno tentar escrever
apenas Departamentos.nome_depto, o banco de dados retornará um erro de ambiguidade.
Escrevemos todas as outras tabelas por extenso, mas fomos obrigados a criar um "nome
temporário" (Depto_Funcionario e Depto_Projeto) apenas para diferenciar as duas
chamadas da mesma tabela.*/





 
 
 

 
 
 