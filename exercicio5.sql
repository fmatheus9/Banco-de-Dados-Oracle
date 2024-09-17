--Consulte a tabela TB_FUNCAO e retorne uma express�o �nica da forma �O identificador da <descri��o da fun��o> � o ID: <id_funcao>�. 
--Utilize um alias para essa express�o de coluna como �Descri��o da Fun��o� usando a palavra-chave AS.
SELECT 'O identificador da ' || ds_funcao || ' � o ID: ' || id_funcao AS "Descri��o da Fun��o"
FROM tb_funcao;


--Usando a tabela DUAL, calcule a �rea de uma circunfer�ncia com um raio de 6000 unidades, com PI sendo,
--aproximadamente, 22/7. Use a f�rmula: �rea = pi x raio x raio. Crie um alias no resultado como ��rea�.
SELECT TRUNC((22/7) * (6000 * 6000), 2) AS "�rea"
FROM dual;


--Recupere o(s) nome(s) do(s) departamento(s) que termine com as tr�s letras �ing� da tabela TB_DEPARTAMENTO.
SELECT nm_departamento 
FROM tb_departamento
WHERE nm_departamento LIKE '%ing';


--A tabela TB_FUNCAO cont�m descri��es de diferentes tipos de fun��es que um empregado da empresa podeocupar. 
--Ela cont�m as colunas ID_FUNCAO, DS_FUNCAO, BASE_SALARIO e TETO_SALARIO. 
--Voc� precisa escrever uma consulta que extraia as colunas DS_FUNCAO, BASE_SALARIO, e a diferen�a entre os valores TETO_SALARIO e BASE_SALARIO para cada linha. 
--Os resultados somente podem incluir valores DS_FUNCAO que contenham a palavra �Presidente� ou �Gerente�. 
--Classifique a lista em ordem descendente baseado na express�o DIFEREN�A. 
--Se mais de uma linha tiver o mesmo valor DIFEREN�A, ent�o, em adi��o, classifique essas linhas por DS_FUNCAO na ordem alfab�tica reversa.
SELECT ds_funcao, base_salario, (teto_salario - base_salario) AS "Diferen�a"
FROM tb_funcao
WHERE ds_funcao LIKE '%Presidente%' OR ds_funcao LIKE '%Gerente%' 
ORDER BY 3 DESC, ds_funcao DESC;


--Para o exerc�cio abaixo, utilize impreterivelmente, vari�veis de substitui��o (& comercial)
--Um c�lculo comum executado pelo Departamento de Recursos Humanos est� relacionado ao c�lculo de impostos cobrados sobre um determinado empregado.
--Apesar disso ser feito para todos os empregados, sempre h� algunsmembros da equipe que discutem os impostos retidos de seus sal�rios.
--O imposto retido por empregado �calculado obtendo o sal�rio anual do empregado e multiplicando-o pela al�quota atual, que pode variar de ano paraano. 
--Voc� precisa escrever uma consulta reutiliz�vel usando a al�quota atual e os n�meros ID_EMPREGADO como entradas e retornar as informa��es: 
--ID_EMPREGADO, NOME, SALARIO, SALARIO ANUAL (SALARIO * 12), ALIQUOTA, e ALIQUOTA (ALIQUOTA * SALARIO ANUAL).

ACCEPT aliquota NUMBER PROMPT 'Entre com a al�quota: '
ACCEPT v_id_empregado NUMBER PROMPT 'Entre com o ID: '
SELECT id_empregado, nome, salario, salario*12 AS "Sal�rio anual", &aliquota AS "Al�quota", salario*12 *&aliquota AS "Imposto"
FROM tb_empregado
WHERE id_empregado = &v_id_empregado;
