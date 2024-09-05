@ C:\temp\teste_4.sql 6 19.99

SELECT 'DROP TABLE' || table_name ||';'
FROM user_tables;

CREATE TABLE tb_teste(
id      INTEGER,
valor   VARCHAR2(100)
);

BEGIN 

    FOR v_loop IN 1..100000 LOOP
        INSERT INTO tb_teste(id, valor)
        VALUES (v_loop, 'DBA_' || v_loop);
    END LOOP;

END;

SELECT *
FROM tb_teste
ORDER BY 1 DESC;

TRUNCATE TABLE tb_teste;


--CRIAR UM STORED PROCEDURE (Procedimento armazenado ou Stored Procedure � uma 
                            --cole��o de comandos em SQL, que podem ser executadas em um Banco de dados de uma s� vez, como em uma fun��o.) 
--OBJETIVO: REALIZAR INSTRUCOES DE INSERT, UPDATE, DELETE EM UMA DETERMINADA TABELA POR MEIO DA PASAGEM DE PAR�METROS
CREATE TABLE tb_cliente_teste(
id_cliente          INTEGER,
ds_cliente          VARCHAR2(20),
nm_cliente          VARCHAR2(40),
valor               NUMERIC,
fg_ativo            INTEGER,
PRIMARY KEY(id_cliente)
);

CREATE OR REPLACE PROCEDURE manipula_dados(
    p_id_cliente IN tb_cliente_teste.id_cliente%TYPE,
    p_descricao  IN tb_cliente_teste.ds_cliente%TYPE,
    p_nome       IN tb_cliente_teste.nm_cliente%TYPE,
    p_valor      IN tb_cliente_teste.valor%TYPE,
    p_fg_ativo   IN tb_cliente_teste.fg_ativo%TYPE,
    p_opcao      IN CHAR)
AS
  v_controle  INTEGER;
BEGIN
  --verifica a exist�ncia de tuplas na "tb_cliente_teste"
  SELECT COUNT(1) INTO v_controle
  FROM tb_cliente_teste
  WHERE id_cliente = p_id_cliente
  AND fg_ativo = 1; 
  
  --opcao = I (INSERT)
  IF (p_opcao = 'I') THEN
    IF (v_controle != 1) THEN
      INSERT INTO tb_cliente_teste(id_cliente, ds_cliente, nm_cliente, valor, fg_ativo)
      VALUES
      (p_id_cliente, p_descricao, p_nome, p_valor, p_fg_ativo);
      
      COMMIT;
      
      dbms_output.put_line('Cliente inserido com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente j� existe');
    END IF;
  END IF;  
  
  -- opcao = U (UPDATE)
  IF (p_opcao = 'U') THEN
    IF (v_controle = 1) THEN
      UPDATE tb_cliente_teste SET ds_cliente = p_descricao,
                                  nm_cliente = p_nome,
                                  valor      = p_valor,
                                  fg_ativo   = p_fg_ativo
      WHERE id_cliente = p_id_cliente
      AND fg_ativo = 1;
      
      COMMIT;
      
      dbms_output.put_line('Cliente alterado com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente n�o existe');
    END IF;
  END IF;
  
  -- opcao = D (DELETE)
  IF (p_opcao = 'D') THEN
    IF (v_controle = 1) THEN
      DELETE
      FROM tb_cliente_teste
      WHERE id_cliente = p_id_cliente
      AND fg_ativo = 1;
      
      COMMIT;
      
      dbms_output.put_line('Cliente exclu�do com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente n�o existe');
    END IF;
  END IF;
  
EXCEPTION
  WHEN others THEN
    ROLLBACK;
  
END manipula_dados;

-- Habilitar a sa�da DBMS
-- Menu Exibir > Sa�da DBMS
-- opcao inserir (par�metro opcao = I)
CALL manipula_dados(1, 'Cliente 1', 'Nome do cliente 1', 22, 1, 'I');

-- opcao inserir (par�metro opcao = I)
CALL manipula_dados(2, 'Cliente 2', 'Nome do cliente 2', 99, 1, 'I');


-- opcao alterar (par�metro opcao = U)
CALL manipula_dados(2, 'Cliente alterado hoje', 'Alterado', 110, 1, 'U');

-- opcao excluir (par�metro opcao = D)
CALL manipula_dados(2, NULL, NULL, NULL, NULL, 'D');

SELECT *
FROM tb_cliente_teste;
