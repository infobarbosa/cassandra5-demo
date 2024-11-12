---------------------------------------------------------
-- Keyspace infobarbank
---------------------------------------------------------
CREATE KEYSPACE infobarbank 
WITH replication = {
    'class': 'NetworkTopologyStrategy', 
    'replication_factor': 1};

---------------------------------------------------------
--               CLIENTE     
---------------------------------------------------------
CREATE TABLE infobarbank.cliente (
    ID int PRIMARY KEY,
    Codigo int,
    Nome_Completo text,
    CPF text,
    Email text,
    Telefone text,
    Data_Nascimento text,
    Salario text,
    Estado text
);


INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1001, 1, 'MARIVALDA KANAMARY', '987.539.360-60', 'marivalda@bmail.com', '(11) 987654321', '06/02/1997', 'R$5.000,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1002, 2, 'JUCILENE MOREIRA CRUZ', '124.554.260-50', 'jucilene@bmail.com', '(21) 945678900', '06/02/1944', 'R$2.500,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1003, 3, 'GRACIMAR BRASIL GUERRA', '324.873.000-51', 'gracimar@bmail.com', '(21) 934455667', '03/08/1946', 'R$10.000,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1004, 4, 'ALDENORA VIANA MOREIRA', '598.131.330-74', 'aldenora@gmail.com', '(11) 999775533', '04/07/1970', 'R$3.000,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1005, 5, 'VERA LUCIA RODRIGUES SENA', '797.399.520-03', 'vera@bmail.com', '(31) 987987988', '01/06/2004', 'R$2.500,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1006, 6, 'IVONE GLAUCIA VIANA DUTRA', '661.428.060-00', 'ivone@bmail.com', '(11) 934877563', '13/01/1982', 'R$4.000,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1007, 7, 'LUCILIA ROSA LIMA PEREIRA', '190.523.300-00', 'lucilia@yahoo.com', '(31) 911277444', '19/07/1954', 'R$20.000,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1008, 8, 'RAIMUNDA PEREIRA LIMA', '432.098.160-90', 'raimunda@bmail.com', '(61) 999887766', '23/09/1965', 'R$7.000,00', 'DF');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1009, 9, 'MARIA DO SOCORRO SILVA', '129.384.250-60', 'mariasocorro@bmail.com', '(11) 965431221', '30/01/1990', 'R$3.500,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1010, 10, 'JOÃO CARLOS SILVA', '839.239.480-71', 'joao@bmail.com', '(21) 954321223', '12/12/1983', 'R$5.500,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1011, 11, 'ANA PAULA COSTA', '582.321.910-23', 'ana@bmail.com', '(41) 963212312', '05/06/1995', 'R$6.200,00', 'PR');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1012, 12, 'FRANCISCO OLIVEIRA LIMA', '923.984.230-12', 'francisco@bmail.com', '(81) 984532112', '17/03/1972', 'R$4.800,00', 'PE');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1013, 13, 'CLAUDIA APARECIDA DOS SANTOS', '102.394.870-34', 'claudia@bmail.com', '(31) 978787878', '08/11/1985', 'R$3.700,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1014, 14, 'LUCAS GOMES SILVA', '829.482.650-45', 'lucas@bmail.com', '(71) 923456712', '11/08/1993', 'R$4.900,00', 'BA');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1015, 15, 'PAULO CESAR FERREIRA', '294.829.470-56', 'paulo@bmail.com', '(51) 954321223', '22/05/1987', 'R$5.300,00', 'RS');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1016, 16, 'ROSANA MARIA TEIXEIRA', '594.238.920-67', 'rosana@bmail.com', '(21) 963212123', '03/02/1981', 'R$6.000,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1017, 17, 'MARCOS ANTONIO DA SILVA', '192.834.780-78', 'marcos@bmail.com', '(11) 944556677', '19/12/1969', 'R$9.500,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1018, 18, 'RENATA ALMEIDA GONÇALVES', '219.384.290-89', 'renata@bmail.com', '(31) 966554433', '02/09/1974', 'R$4.200,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1019, 19, 'ANTONIO JOSÉ PEREIRA', '203.947.560-90', 'antonio@bmail.com', '(85) 955667788', '25/11/1966', 'R$5.800,00', 'CE');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1020, 20, 'FABIANA SILVA MENEZES', '875.392.340-91', 'fabiana@bmail.com', '(61) 999667788', '07/07/1975', 'R$7.200,00', 'DF');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1021, 21, 'CARLOS EDUARDO MARTINS', '892.394.120-12', 'carlos@bmail.com', '(21) 965432211', '21/01/1991', 'R$4.600,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1022, 22, 'EDSON LUIZ PEREIRA', '204.839.470-23', 'edson@bmail.com', '(11) 977665544', '29/10/1988', 'R$5.700,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1023, 23, 'JOANA FERREIRA DOS SANTOS', '198.234.780-34', 'joana@bmail.com', '(41) 968756434', '05/06/1992', 'R$4.500,00', 'PR');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1024, 24, 'ADRIANA MOURA', '320.984.230-45', 'adriana@bmail.com', '(71) 932156712', '15/08/1986', 'R$4.300,00', 'BA');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1025, 25, 'RICARDO GOMES PEREIRA', '198.472.650-56', 'ricardo@bmail.com', '(51) 933456712', '27/05/1995', 'R$5.600,00', 'RS');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1026, 26, 'JULIANA MENDES DA SILVA', '592.238.920-67', 'juliana@bmail.com', '(21) 962232123', '08/02/1983', 'R$5.000,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1027, 27, 'MARCELO TEIXEIRA LIMA', '103.839.470-78', 'marcelo@bmail.com', '(11) 944576677', '12/12/1979', 'R$8.900,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1028, 28, 'FERNANDA LOPES PEREIRA', '204.938.560-89', 'fernanda@bmail.com', '(31) 966564433', '16/09/1990', 'R$4.700,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1029, 29, 'JOÃO CARLOS DA SILVA', '212.947.560-90', 'joaocarlos@bmail.com', '(85) 953567788', '25/03/1984', 'R$6.800,00', 'CE');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1030, 30, 'ELIZABETH SOUZA SILVA', '875.392.340-91', 'elizabeth@bmail.com', '(61) 999667899', '18/08/1987', 'R$7.500,00', 'DF');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1031, 31, 'ROBERTO CARLOS MARTINS', '892.394.120-12', 'roberto@bmail.com', '(21) 964432211', '13/02/1992', 'R$4.900,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1032, 32, 'SANDRA REGINA PEREIRA', '204.839.470-23', 'sandra@bmail.com', '(11) 975665544', '29/11/1980', 'R$5.200,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1033, 33, 'JOSÉ ANTONIO DOS SANTOS', '195.234.780-34', 'joseantonio@bmail.com', '(41) 968756734', '15/06/1969', 'R$9.200,00', 'PR');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1034, 34, 'MONICA TEIXEIRA', '320.984.230-45', 'monica@bmail.com', '(71) 922156712', '21/07/1972', 'R$6.000,00', 'BA');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1035, 35, 'ANDREIA GOMES PEREIRA', '198.472.650-56', 'andreia@bmail.com', '(51) 933456733', '11/05/1994', 'R$5.100,00', 'RS');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1036, 36, 'FABIO MENDES DA SILVA', '592.238.920-67', 'fabio@bmail.com', '(21) 964232124', '12/02/1979', 'R$6.300,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1037, 37, 'MARCIA TEIXEIRA LIMA', '103.839.470-78', 'marcia@bmail.com', '(11) 944576778', '10/12/1982', 'R$8.100,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1038, 38, 'ANA LUCIA LOPES PEREIRA', '204.938.560-89', 'analucia@bmail.com', '(31) 966564488', '15/09/1977', 'R$5.400,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1039, 39, 'PEDRO HENRIQUE DA SILVA', '212.947.560-90', 'pedrohenrique@bmail.com', '(85) 953567789', '18/04/1983', 'R$7.300,00', 'CE');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1040, 40, 'CAMILA SOUZA SILVA', '875.392.340-91', 'camila@bmail.com', '(61) 999667788', '23/05/1995', 'R$6.800,00', 'DF');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1041, 41, 'MARIA EDUARDA MARTINS', '892.394.120-12', 'mariaeduarda@bmail.com', '(21) 962432221', '12/01/1997', 'R$4.600,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1042, 42, 'RODRIGO CARLOS MARTINS', '892.394.120-12', 'rodrigo@bmail.com', '(21) 964433321', '18/06/1993', 'R$5.400,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1041, 41, 'MARIA EDUARDA MARTINS', '892.394.120-12', 'mariaeduarda@bmail.com', '(21) 962432221', '12/01/1997', 'R$4.600,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1042, 42, 'RODRIGO CARLOS MARTINS', '892.394.120-12', 'rodrigo@bmail.com', '(21) 964433321', '18/06/1993', 'R$5.400,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1043, 43, 'LUANA REGINA PEREIRA', '204.839.470-23', 'luana@bmail.com', '(11) 974665544', '22/09/1986', 'R$5.700,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1044, 44, 'MARIA FERNANDA DOS SANTOS', '195.234.780-34', 'mariafernanda@bmail.com', '(41) 969756734', '19/04/1991', 'R$4.800,00', 'PR');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1045, 45, 'GUSTAVO TEIXEIRA', '320.984.230-45', 'gustavo@bmail.com', '(71) 922456712', '25/05/1987', 'R$6.300,00', 'BA');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1046, 46, 'PAULA GOMES PEREIRA', '198.472.650-56', 'paula@bmail.com', '(51) 933456732', '18/05/1992', 'R$5.900,00', 'RS');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1047, 47, 'CAROLINA MENDES DA SILVA', '592.238.920-67', 'carolina@bmail.com', '(21) 963332124', '21/02/1993', 'R$6.100,00', 'RJ');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1048, 48, 'CLAUDIO TEIXEIRA LIMA', '103.839.470-78', 'claudio@bmail.com', '(11) 944476677', '24/12/1982', 'R$7.100,00', 'SP');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1049, 49, 'FABIANO LOPES PEREIRA', '204.938.560-89', 'fabiano@bmail.com', '(31) 966564477', '28/09/1980', 'R$5.600,00', 'MG');
INSERT INTO infobarbank.cliente (ID, Codigo, Nome_Completo, CPF, Email, Telefone, Data_Nascimento, Salario, Estado) VALUES (1050, 50, 'JULIO CESAR DA SILVA', '212.947.560-90', 'juliocesar@bmail.com', '(85) 953567787', '31/03/1988', 'R$6.500,00', 'CE');

---------------------------------------------------------
--               CLIENTE_POR_TELEFONE     
---------------------------------------------------------
CREATE TABLE infobarbank.cliente_por_telefone (
    Telefone text,
    ID int,
    Codigo int,
    Nome_Completo text,
    CPF text,
    Email text,
    Data_Nascimento text,
    Salario text,
    Estado text,
    PRIMARY KEY (Telefone, ID)
);

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 987654321', 1001, 1, 'MARIVALDA KANAMARY', '987.539.360-60', 'marivalda@bmail.com', '06/02/1997', 'R$5.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 945678900', 1002, 2, 'JUCILENE MOREIRA CRUZ', '124.554.260-50', 'jucilene@bmail.com', '06/02/1944', 'R$2.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 934455667', 1003, 3, 'GRACIMAR BRASIL GUERRA', '324.873.000-51', 'gracimar@bmail.com', '03/08/1946', 'R$10.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 999775533', 1004, 4, 'ALDENORA VIANA MOREIRA', '598.131.330-74', 'aldenora@gmail.com', '04/07/1970', 'R$3.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 987987988', 1005, 5, 'VERA LUCIA RODRIGUES SENA', '797.399.520-03', 'vera@bmail.com', '01/06/2004', 'R$2.500,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 934877563', 1006, 6, 'IVONE GLAUCIA VIANA DUTRA', '661.428.060-00', 'ivone@bmail.com', '13/01/1982', 'R$4.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 911277444', 1007, 7, 'LUCILIA ROSA LIMA PEREIRA', '190.523.300-00', 'lucilia@yahoo.com', '19/07/1954', 'R$20.000,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(61) 999887766', 1008, 8, 'RAIMUNDA PEREIRA LIMA', '432.098.160-90', 'raimunda@bmail.com', '23/09/1965', 'R$7.000,00', 'DF');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 965431221', 1009, 9, 'MARIA DO SOCORRO SILVA', '129.384.250-60', 'mariasocorro@bmail.com', '30/01/1990', 'R$3.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 954321223', 1010, 10, 'JOÃO CARLOS SILVA', '839.239.480-71', 'joao@bmail.com', '12/12/1983', 'R$5.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(41) 963212312', 1011, 11, 'ANA PAULA COSTA', '582.321.910-23', 'ana@bmail.com', '05/06/1995', 'R$6.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(81) 984532112', 1012, 12, 'FRANCISCO OLIVEIRA LIMA', '923.984.230-12', 'francisco@bmail.com', '17/03/1972', 'R$4.800,00', 'PE');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 978787878', 1013, 13, 'CLAUDIA APARECIDA DOS SANTOS', '102.394.870-34', 'claudia@bmail.com', '08/11/1985', 'R$3.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(71) 923456712', 1014, 14, 'LUCAS GOMES SILVA', '829.482.650-45', 'lucas@bmail.com', '11/08/1993', 'R$4.900,00', 'BA');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(51) 954321223', 1015, 15, 'PAULO CESAR FERREIRA', '294.829.470-56', 'paulo@bmail.com', '22/05/1987', 'R$5.300,00', 'RS');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 963212123', 1016, 16, 'ROSANA MARIA TEIXEIRA', '594.238.920-67', 'rosana@bmail.com', '03/02/1981', 'R$6.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 944556677', 1017, 17, 'MARCOS ANTONIO DA SILVA', '192.834.780-78', 'marcos@bmail.com', '19/12/1969', 'R$9.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 966554433', 1018, 18, 'RENATA ALMEIDA GONÇALVES', '219.384.290-89', 'renata@bmail.com', '02/09/1974', 'R$4.200,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(85) 955667788', 1019, 19, 'ANTONIO JOSÉ PEREIRA', '203.947.560-90', 'antonio@bmail.com', '25/11/1966', 'R$5.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(61) 999667788', 1020, 20, 'FABIANA SILVA MENEZES', '875.392.340-91', 'fabiana@bmail.com', '07/07/1975', 'R$7.200,00', 'DF');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 965432211', 1021, 21, 'CARLOS EDUARDO MARTINS', '892.394.120-12', 'carlos@bmail.com', '21/01/1991', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 977665544', 1022, 22, 'EDSON LUIZ PEREIRA', '204.839.470-23', 'edson@bmail.com', '29/10/1988', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(41) 968756434', 1023, 23, 'JOANA FERREIRA DOS SANTOS', '198.234.780-34', 'joana@bmail.com', '05/06/1992', 'R$4.500,00', 'PR');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(71) 932156712', 1024, 24, 'ADRIANA MOURA', '320.984.230-45', 'adriana@bmail.com', '15/08/1986', 'R$4.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(51) 933456712', 1025, 25, 'RICARDO GOMES PEREIRA', '198.472.650-56', 'ricardo@bmail.com', '27/05/1995', 'R$5.600,00', 'RS');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 962232123', 1026, 26, 'JULIANA MENDES DA SILVA', '592.238.920-67', 'juliana@bmail.com', '08/02/1983', 'R$5.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 944576677', 1027, 27, 'MARCELO TEIXEIRA LIMA', '103.839.470-78', 'marcelo@bmail.com', '12/12/1979', 'R$8.900,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 966564433', 1028, 28, 'FERNANDA LOPES PEREIRA', '204.938.560-89', 'fernanda@bmail.com', '16/09/1990', 'R$4.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(85) 953567788', 1029, 29, 'JOÃO CARLOS DA SILVA', '212.947.560-90', 'joaocarlos@bmail.com', '25/03/1984', 'R$6.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(61) 999667899', 1030, 30, 'ELIZABETH SOUZA SILVA', '875.392.340-91', 'elizabeth@bmail.com', '18/08/1987', 'R$7.500,00', 'DF');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 964432211', 1031, 31, 'ROBERTO CARLOS MARTINS', '892.394.120-12', 'roberto@bmail.com', '13/02/1992', 'R$4.900,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 975665544', 1032, 32, 'SANDRA REGINA PEREIRA', '204.839.470-23', 'sandra@bmail.com', '29/11/1980', 'R$5.200,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(41) 968756734', 1033, 33, 'JOSÉ ANTONIO DOS SANTOS', '195.234.780-34', 'joseantonio@bmail.com', '15/06/1969', 'R$9.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(71) 922156712', 1034, 34, 'MONICA TEIXEIRA', '320.984.230-45', 'monica@bmail.com', '21/07/1972', 'R$6.000,00', 'BA');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(51) 933456733', 1035, 35, 'ANDREIA GOMES PEREIRA', '198.472.650-56', 'andreia@bmail.com', '11/05/1994', 'R$5.100,00', 'RS');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 964232124', 1036, 36, 'FABIO MENDES DA SILVA', '592.238.920-67', 'fabio@bmail.com', '12/02/1979', 'R$6.300,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 944576778', 1037, 37, 'MARCIA TEIXEIRA LIMA', '103.839.470-78', 'marcia@bmail.com', '10/12/1982', 'R$8.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 966564488', 1038, 38, 'ANA LUCIA LOPES PEREIRA', '204.938.560-89', 'analucia@bmail.com', '15/09/1977', 'R$5.400,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(85) 953567789', 1039, 39, 'PEDRO HENRIQUE DA SILVA', '212.947.560-90', 'pedrohenrique@bmail.com', '18/04/1983', 'R$7.300,00', 'CE');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(61) 999667788', 1040, 40, 'CAMILA SOUZA SILVA', '875.392.340-91', 'camila@bmail.com', '23/05/1995', 'R$6.800,00', 'DF');
INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 962432221', 1041, 41, 'MARIA EDUARDA MARTINS', '892.394.120-12', 'mariaeduarda@bmail.com', '12/01/1997', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 964433321', 1042, 42, 'RODRIGO CARLOS MARTINS', '892.394.120-12', 'rodrigo@bmail.com', '18/06/1993', 'R$5.400,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 974665544', 1043, 43, 'LUANA REGINA PEREIRA', '204.839.470-23', 'luana@bmail.com', '22/09/1986', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(41) 969756734', 1044, 44, 'MARIA FERNANDA DOS SANTOS', '195.234.780-34', 'mariafernanda@bmail.com', '19/04/1991', 'R$4.800,00', 'PR');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(71) 922456712', 1045, 45, 'GUSTAVO TEIXEIRA', '320.984.230-45', 'gustavo@bmail.com', '25/05/1987', 'R$6.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(51) 933456732', 1046, 46, 'PAULA GOMES PEREIRA', '198.472.650-56', 'paula@bmail.com', '18/05/1992', 'R$5.900,00', 'RS');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(21) 963332124', 1047, 47, 'CAROLINA MENDES DA SILVA', '592.238.920-67', 'carolina@bmail.com', '21/02/1993', 'R$6.100,00', 'RJ');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(11) 944476677', 1048, 48, 'CLAUDIO TEIXEIRA LIMA', '103.839.470-78', 'claudio@bmail.com', '24/12/1982', 'R$7.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(31) 966564477', 1049, 49, 'FABIANO LOPES PEREIRA', '204.938.560-89', 'fabiano@bmail.com', '28/09/1980', 'R$5.600,00', 'MG');

INSERT INTO infobarbank.cliente_por_telefone (Telefone, ID, Codigo, Nome_Completo, CPF, Email, Data_Nascimento, Salario, Estado)
VALUES ('(85) 953567787', 1050, 50, 'JULIO CESAR DA SILVA', '212.947.560-90', 'juliocesar@bmail.com', '31/03/1988', 'R$6.500,00', 'CE');


---------------------------------------------------------
--               CLIENTE_POR_EMAIL                               
---------------------------------------------------------

CREATE TABLE infobarbank.cliente_por_email (
    Email text,
    ID int,
    Codigo int,
    Nome_Completo text,
    CPF text,
    Telefone text,
    Data_Nascimento text,
    Salario text,
    Estado text,
    PRIMARY KEY (Email, ID)
);


INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('marivalda@bmail.com', 1001, 1, 'MARIVALDA KANAMARY', '987.539.360-60', '(11) 987654321', '06/02/1997', 'R$5.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('jucilene@bmail.com', 1002, 2, 'JUCILENE MOREIRA CRUZ', '124.554.260-50', '(21) 945678900', '06/02/1944', 'R$2.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('gracimar@bmail.com', 1003, 3, 'GRACIMAR BRASIL GUERRA', '324.873.000-51', '(21) 934455667', '03/08/1946', 'R$10.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('aldenora@gmail.com', 1004, 4, 'ALDENORA VIANA MOREIRA', '598.131.330-74', '(11) 999775533', '04/07/1970', 'R$3.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('vera@bmail.com', 1005, 5, 'VERA LUCIA RODRIGUES SENA', '797.399.520-03', '(31) 987987988', '01/06/2004', 'R$2.500,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('ivone@bmail.com', 1006, 6, 'IVONE GLAUCIA VIANA DUTRA', '661.428.060-00', '(11) 934877563', '13/01/1982', 'R$4.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('lucilia@yahoo.com', 1007, 7, 'LUCILIA ROSA LIMA PEREIRA', '190.523.300-00', '(31) 911277444', '19/07/1954', 'R$20.000,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('raimunda@bmail.com', 1008, 8, 'RAIMUNDA PEREIRA LIMA', '432.098.160-90', '(61) 999887766', '23/09/1965', 'R$7.000,00', 'DF');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('mariasocorro@bmail.com', 1009, 9, 'MARIA DO SOCORRO SILVA', '129.384.250-60', '(11) 965431221', '30/01/1990', 'R$3.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('joao@bmail.com', 1010, 10, 'JOÃO CARLOS SILVA', '839.239.480-71', '(21) 954321223', '12/12/1983', 'R$5.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('ana@bmail.com', 1011, 11, 'ANA PAULA COSTA', '582.321.910-23', '(41) 963212312', '05/06/1995', 'R$6.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('francisco@bmail.com', 1012, 12, 'FRANCISCO OLIVEIRA LIMA', '923.984.230-12', '(81) 984532112', '17/03/1972', 'R$4.800,00', 'PE');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('claudia@bmail.com', 1013, 13, 'CLAUDIA APARECIDA DOS SANTOS', '102.394.870-34', '(31) 978787878', '08/11/1985', 'R$3.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('lucas@bmail.com', 1014, 14, 'LUCAS GOMES SILVA', '829.482.650-45', '(71) 923456712', '11/08/1993', 'R$4.900,00', 'BA');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('paulo@bmail.com', 1015, 15, 'PAULO CESAR FERREIRA', '294.829.470-56', '(51) 954321223', '22/05/1987', 'R$5.300,00', 'RS');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('rosana@bmail.com', 1016, 16, 'ROSANA MARIA TEIXEIRA', '594.238.920-67', '(21) 963212123', '03/02/1981', 'R$6.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('marcos@bmail.com', 1017, 17, 'MARCOS ANTONIO DA SILVA', '192.834.780-78', '(11) 944556677', '19/12/1969', 'R$9.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('renata@bmail.com', 1018, 18, 'RENATA ALMEIDA GONÇALVES', '219.384.290-89', '(31) 966554433', '02/09/1974', 'R$4.200,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('antonio@bmail.com', 1019, 19, 'ANTONIO JOSÉ PEREIRA', '203.947.560-90', '(85) 955667788', '25/11/1966', 'R$5.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('fabiana@bmail.com', 1020, 20, 'FABIANA SILVA MENEZES', '875.392.340-91', '(61) 999667788', '07/07/1975', 'R$7.200,00', 'DF');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('carlos@bmail.com', 1021, 21, 'CARLOS EDUARDO MARTINS', '892.394.120-12', '(21) 965432211', '21/01/1991', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('edson@bmail.com', 1022, 22, 'EDSON LUIZ PEREIRA', '204.839.470-23', '(11) 977665544', '29/10/1988', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('joana@bmail.com', 1023, 23, 'JOANA FERREIRA DOS SANTOS', '198.234.780-34', '(41) 968756434', '05/06/1992', 'R$4.500,00', 'PR');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('adriana@bmail.com', 1024, 24, 'ADRIANA MOURA', '320.984.230-45', '(71) 932156712', '15/08/1986', 'R$4.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('ricardo@bmail.com', 1025, 25, 'RICARDO GOMES PEREIRA', '198.472.650-56', '(51) 933456712', '27/05/1995', 'R$5.600,00', 'RS');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('juliana@bmail.com', 1026, 26, 'JULIANA MENDES DA SILVA', '592.238.920-67', '(21) 962232123', '08/02/1983', 'R$5.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('marcelo@bmail.com', 1027, 27, 'MARCELO TEIXEIRA LIMA', '103.839.470-78', '(11) 944576677', '12/12/1979', 'R$8.900,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('fernanda@bmail.com', 1028, 28, 'FERNANDA LOPES PEREIRA', '204.938.560-89', '(31) 966564433', '16/09/1990', 'R$4.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('joaocarlos@bmail.com', 1029, 29, 'JOÃO CARLOS DA SILVA', '212.947.560-90', '(85) 953567788', '25/03/1984', 'R$6.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('elizabeth@bmail.com', 1030, 30, 'ELIZABETH SOUZA SILVA', '875.392.340-91', '(61) 999667899', '18/08/1987', 'R$7.500,00', 'DF');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('elizabeth@bmail.com', 1030, 30, 'ELIZABETH SOUZA SILVA', '875.392.340-91', '(61) 999667899', '18/08/1987', 'R$7.500,00', 'DF');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('roberto@bmail.com', 1031, 31, 'ROBERTO CARLOS MARTINS', '892.394.120-12', '(21) 964432211', '13/02/1992', 'R$4.900,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('sandra@bmail.com', 1032, 32, 'SANDRA REGINA PEREIRA', '204.839.470-23', '(11) 975665544', '29/11/1980', 'R$5.200,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('joseantonio@bmail.com', 1033, 33, 'JOSÉ ANTONIO DOS SANTOS', '195.234.780-34', '(41) 968756734', '15/06/1969', 'R$9.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('monica@bmail.com', 1034, 34, 'MONICA TEIXEIRA', '320.984.230-45', '(71) 922156712', '21/07/1972', 'R$6.000,00', 'BA');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('andreia@bmail.com', 1035, 35, 'ANDREIA GOMES PEREIRA', '198.472.650-56', '(51) 933456733', '11/05/1994', 'R$5.100,00', 'RS');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('fabio@bmail.com', 1036, 36, 'FABIO MENDES DA SILVA', '592.238.920-67', '(21) 964232124', '12/02/1979', 'R$6.300,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('marcia@bmail.com', 1037, 37, 'MARCIA TEIXEIRA LIMA', '103.839.470-78', '(11) 944576778', '10/12/1982', 'R$8.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('analucia@bmail.com', 1038, 38, 'ANA LUCIA LOPES PEREIRA', '204.938.560-89', '(31) 966564488', '15/09/1977', 'R$5.400,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('pedrohenrique@bmail.com', 1039, 39, 'PEDRO HENRIQUE DA SILVA', '212.947.560-90', '(85) 953567789', '18/04/1983', 'R$7.300,00', 'CE');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('camila@bmail.com', 1040, 40, 'CAMILA SOUZA SILVA', '875.392.340-91', '(61) 999667788', '23/05/1995', 'R$6.800,00', 'DF');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('mariaeduarda@bmail.com', 1041, 41, 'MARIA EDUARDA MARTINS', '892.394.120-12', '(21) 962432221', '12/01/1997', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('rodrigo@bmail.com', 1042, 42, 'RODRIGO CARLOS MARTINS', '892.394.120-12', '(21) 964433321', '18/06/1993', 'R$5.400,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('luana@bmail.com', 1043, 43, 'LUANA REGINA PEREIRA', '204.839.470-23', '(11) 974665544', '22/09/1986', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('mariafernanda@bmail.com', 1044, 44, 'MARIA FERNANDA DOS SANTOS', '195.234.780-34', '(41) 969756734', '19/04/1991', 'R$4.800,00', 'PR');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('gustavo@bmail.com', 1045, 45, 'GUSTAVO TEIXEIRA', '320.984.230-45', '(71) 922456712', '25/05/1987', 'R$6.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('paula@bmail.com', 1046, 46, 'PAULA GOMES PEREIRA', '198.472.650-56', '(51) 933456732', '18/05/1992', 'R$5.900,00', 'RS');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('carolina@bmail.com', 1047, 47, 'CAROLINA MENDES DA SILVA', '592.238.920-67', '(21) 963332124', '21/02/1993', 'R$6.100,00', 'RJ');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('claudio@bmail.com', 1048, 48, 'CLAUDIO TEIXEIRA LIMA', '103.839.470-78', '(11) 944476677', '24/12/1982', 'R$7.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('fabiano@bmail.com', 1049, 49, 'FABIANO LOPES PEREIRA', '204.938.560-89', '(31) 966564477', '28/09/1980', 'R$5.600,00', 'MG');

INSERT INTO infobarbank.cliente_por_email (Email, ID, Codigo, Nome_Completo, CPF, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('juliocesar@bmail.com', 1050, 50, 'JULIO CESAR DA SILVA', '212.947.560-90', '(85) 953567787', '31/03/1988', 'R$6.500,00', 'CE');


---------------------------------------------------------
--               CLIENTE_POR_CPF                               
---------------------------------------------------------
CREATE TABLE infobarbank.cliente_por_cpf (
    CPF text,
    ID int,
    Codigo int,
    Nome_Completo text,
    Email text,
    Telefone text,
    Data_Nascimento text,
    Salario text,
    Estado text,
    PRIMARY KEY (CPF, ID)
);

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('987.539.360-60', 1001, 1, 'MARIVALDA KANAMARY', 'marivalda@bmail.com', '(11) 987654321', '06/02/1997', 'R$5.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('124.554.260-50', 1002, 2, 'JUCILENE MOREIRA CRUZ', 'jucilene@bmail.com', '(21) 945678900', '06/02/1944', 'R$2.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('324.873.000-51', 1003, 3, 'GRACIMAR BRASIL GUERRA', 'gracimar@bmail.com', '(21) 934455667', '03/08/1946', 'R$10.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('598.131.330-74', 1004, 4, 'ALDENORA VIANA MOREIRA', 'aldenora@gmail.com', '(11) 999775533', '04/07/1970', 'R$3.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('797.399.520-03', 1005, 5, 'VERA LUCIA RODRIGUES SENA', 'vera@bmail.com', '(31) 987987988', '01/06/2004', 'R$2.500,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('661.428.060-00', 1006, 6, 'IVONE GLAUCIA VIANA DUTRA', 'ivone@bmail.com', '(11) 934877563', '13/01/1982', 'R$4.000,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('190.523.300-00', 1007, 7, 'LUCILIA ROSA LIMA PEREIRA', 'lucilia@yahoo.com', '(31) 911277444', '19/07/1954', 'R$20.000,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('432.098.160-90', 1008, 8, 'RAIMUNDA PEREIRA LIMA', 'raimunda@bmail.com', '(61) 999887766', '23/09/1965', 'R$7.000,00', 'DF');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('129.384.250-60', 1009, 9, 'MARIA DO SOCORRO SILVA', 'mariasocorro@bmail.com', '(11) 965431221', '30/01/1990', 'R$3.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('839.239.480-71', 1010, 10, 'JOÃO CARLOS SILVA', 'joao@bmail.com', '(21) 954321223', '12/12/1983', 'R$5.500,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('582.321.910-23', 1011, 11, 'ANA PAULA COSTA', 'ana@bmail.com', '(41) 963212312', '05/06/1995', 'R$6.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('923.984.230-12', 1012, 12, 'FRANCISCO OLIVEIRA LIMA', 'francisco@bmail.com', '(81) 984532112', '17/03/1972', 'R$4.800,00', 'PE');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('102.394.870-34', 1013, 13, 'CLAUDIA APARECIDA DOS SANTOS', 'claudia@bmail.com', '(31) 978787878', '08/11/1985', 'R$3.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('829.482.650-45', 1014, 14, 'LUCAS GOMES SILVA', 'lucas@bmail.com', '(71) 923456712', '11/08/1993', 'R$4.900,00', 'BA');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('294.829.470-56', 1015, 15, 'PAULO CESAR FERREIRA', 'paulo@bmail.com', '(51) 954321223', '22/05/1987', 'R$5.300,00', 'RS');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('594.238.920-67', 1016, 16, 'ROSANA MARIA TEIXEIRA', 'rosana@bmail.com', '(21) 963212123', '03/02/1981', 'R$6.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('192.834.780-78', 1017, 17, 'MARCOS ANTONIO DA SILVA', 'marcos@bmail.com', '(11) 944556677', '19/12/1969', 'R$9.500,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('219.384.290-89', 1018, 18, 'RENATA ALMEIDA GONÇALVES', 'renata@bmail.com', '(31) 966554433', '02/09/1974', 'R$4.200,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('203.947.560-90', 1019, 19, 'ANTONIO JOSÉ PEREIRA', 'antonio@bmail.com', '(85) 955667788', '25/11/1966', 'R$5.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('875.392.340-91', 1020, 20, 'FABIANA SILVA MENEZES', 'fabiana@bmail.com', '(61) 999667788', '07/07/1975', 'R$7.200,00', 'DF');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('892.394.120-12', 1021, 21, 'CARLOS EDUARDO MARTINS', 'carlos@bmail.com', '(21) 965432211', '21/01/1991', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.839.470-23', 1022, 22, 'EDSON LUIZ PEREIRA', 'edson@bmail.com', '(11) 977665544', '29/10/1988', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('198.234.780-34', 1023, 23, 'JOANA FERREIRA DOS SANTOS', 'joana@bmail.com', '(41) 968756434', '05/06/1992', 'R$4.500,00', 'PR');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('320.984.230-45', 1024, 24, 'ADRIANA MOURA', 'adriana@bmail.com', '(71) 932156712', '15/08/1986', 'R$4.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('198.472.650-56', 1025, 25, 'RICARDO GOMES PEREIRA', 'ricardo@bmail.com', '(51) 933456712', '27/05/1995', 'R$5.600,00', 'RS');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('592.238.920-67', 1026, 26, 'JULIANA MENDES DA SILVA', 'juliana@bmail.com', '(21) 962232123', '08/02/1983', 'R$5.000,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('103.839.470-78', 1027, 27, 'MARCELO TEIXEIRA LIMA', 'marcelo@bmail.com', '(11) 944576677', '12/12/1979', 'R$8.900,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.938.560-89', 1028, 28, 'FERNANDA LOPES PEREIRA', 'fernanda@bmail.com', '(31) 966564433', '16/09/1990', 'R$4.700,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('212.947.560-90', 1029, 29, 'JOÃO CARLOS DA SILVA', 'joaocarlos@bmail.com', '(85) 953567788', '25/03/1984', 'R$6.800,00', 'CE');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('875.392.340-91', 1030, 30, 'ELIZABETH SOUZA SILVA', 'elizabeth@bmail.com', '(61) 999667899', '18/08/1987', 'R$7.500,00', 'DF');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('892.394.120-12', 1031, 31, 'ROBERTO CARLOS MARTINS', 'roberto@bmail.com', '(21) 964432211', '13/02/1992', 'R$4.900,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.839.470-23', 1032, 32, 'SANDRA REGINA PEREIRA', 'sandra@bmail.com', '(11) 975665544', '29/11/1980', 'R$5.200,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('195.234.780-34', 1033, 33, 'JOSÉ ANTONIO DOS SANTOS', 'joseantonio@bmail.com', '(41) 968756734', '15/06/1969', 'R$9.200,00', 'PR');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('320.984.230-45', 1034, 34, 'MONICA TEIXEIRA', 'monica@bmail.com', '(71) 922156712', '21/07/1972', 'R$6.000,00', 'BA');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('198.472.650-56', 1035, 35, 'ANDREIA GOMES PEREIRA', 'andreia@bmail.com', '(51) 933456733', '11/05/1994', 'R$5.100,00', 'RS');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('592.238.920-67', 1036, 36, 'FABIO MENDES DA SILVA', 'fabio@bmail.com', '(21) 964232124', '12/02/1979', 'R$6.300,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('103.839.470-78', 1037, 37, 'MARCIA TEIXEIRA LIMA', 'marcia@bmail.com', '(11) 944576778', '10/12/1982', 'R$8.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.938.560-89', 1038, 38, 'ANA LUCIA LOPES PEREIRA', 'analucia@bmail.com', '(31) 966564488', '15/09/1977', 'R$5.400,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('212.947.560-90', 1039, 39, 'PEDRO HENRIQUE DA SILVA', 'pedrohenrique@bmail.com', '(85) 953567789', '18/04/1983', 'R$7.300,00', 'CE');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('875.392.340-91', 1040, 40, 'CAMILA SOUZA SILVA', 'camila@bmail.com', '(61) 999667788', '23/05/1995', 'R$6.800,00', 'DF');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('892.394.120-12', 1041, 41, 'MARIA EDUARDA MARTINS', 'mariaeduarda@bmail.com', '(21) 962432221', '12/01/1997', 'R$4.600,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('892.394.120-12', 1042, 42, 'RODRIGO CARLOS MARTINS', 'rodrigo@bmail.com', '(21) 964433321', '18/06/1993', 'R$5.400,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.839.470-23', 1043, 43, 'LUANA REGINA PEREIRA', 'luana@bmail.com', '(11) 974665544', '22/09/1986', 'R$5.700,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('195.234.780-34', 1044, 44, 'MARIA FERNANDA DOS SANTOS', 'mariafernanda@bmail.com', '(41) 969756734', '19/04/1991', 'R$4.800,00', 'PR');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('320.984.230-45', 1045, 45, 'GUSTAVO TEIXEIRA', 'gustavo@bmail.com', '(71) 922456712', '25/05/1987', 'R$6.300,00', 'BA');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('198.472.650-56', 1046, 46, 'PAULA GOMES PEREIRA', 'paula@bmail.com', '(51) 933456732', '18/05/1992', 'R$5.900,00', 'RS');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('592.238.920-67', 1047, 47, 'CAROLINA MENDES DA SILVA', 'carolina@bmail.com', '(21) 963332124', '21/02/1993', 'R$6.100,00', 'RJ');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('103.839.470-78', 1048, 48, 'CLAUDIO TEIXEIRA LIMA', 'claudio@bmail.com', '(11) 944476677', '24/12/1982', 'R$7.100,00', 'SP');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('204.938.560-89', 1049, 49, 'FABIANO LOPES PEREIRA', 'fabiano@bmail.com', '(31) 966564477', '28/09/1980', 'R$5.600,00', 'MG');

INSERT INTO infobarbank.cliente_por_cpf (CPF, ID, Codigo, Nome_Completo, Email, Telefone, Data_Nascimento, Salario, Estado)
VALUES ('212.947.560-90', 1050, 50, 'JULIO CESAR DA SILVA', 'juliocesar@bmail.com', '(85) 953567787', '31/03/1988', 'R$6.500,00', 'CE');

---------------------------------------------------------
--               CONTA_CORRENTE                               
---------------------------------------------------------
CREATE TABLE infobarbank.conta_corrente(
    num_conta           TEXT,
    apelido_cliente     TEXT,
    data_ultimo_acesso  DATE,
    saldo_disponivel    FLOAT,
    PRIMARY KEY(num_conta));

INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b162060', 'MARIVALDA', '2022-09-01', 100.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16242a', 'JUCILENE' , '2022-08-01', 500.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16256a', 'GRACIMAR' , '2022-09-04', 30.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16353c', 'ALDENORA' , '2022-09-03', 1500.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b1636ae', 'VERA'     , '2022-09-02', 70.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16396a', 'IVONE'    , '2022-08-30', 400.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b163bcc', 'LUCILIA'  , '2022-08-31', 350.00);

---------------------------------------------------------
--               CARTAO_CREDITO                          
---------------------------------------------------------

CREATE TABLE infobarbank.cartao_credito(
    id_cliente          TEXT,
    status              TEXT,
    id                  TEXT,
    num_cartao          TEXT,
    cvv	                TEXT,
    data_validade       DATE,
    limite_total        FLOAT,
    limite_disponivel   FLOAT,
    PRIMARY KEY((id_cliente), status, id));

INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '007c2c1c', '5450 3799 9172 8454', '423', '2030-02-21', 1000.00, 900.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '897199aa', '5576 8924 9861 7490', '336', '2030-07-21', 200.00 , 50.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '9a748c3c', '5188 2716 2053 8850', '920', '2024-03-21', 500.00 , 100.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16242a', 'ATIVO', 'a2fab366', '5590 5738 5562 1778', '198', '2024-03-21', 5000.00, 4000.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16256a', 'ATIVO', 'cd586ffb', '5412 2646 1222 3738', '273', '2030-02-21', 3000.00, 1500.00);

---------------------------------------------------------
--              LANCAMENTOS_CARTAO_CREDITO                  
---------------------------------------------------------

CREATE TABLE infobarbank.lancamentos_cartao_credito(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
  ) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC) ;


COPY infobarbank.lancamentos_cartao_credito (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;

---------------------------------------------------------
--               LANCAMENTOS_POR_STATUS                      
---------------------------------------------------------

CREATE TABLE infobarbank.lancamentos_por_status(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), status, data_hora, id)
  ) WITH CLUSTERING ORDER BY (status ASC, data_hora DESC, id ASC);

COPY infobarbank.lancamentos_por_status (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;

---------------------------------------------------------
--               LANCAMENTOS_POR_PERIODO                      
---------------------------------------------------------

CREATE TABLE infobarbank.lancamentos_por_periodo(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id)
  ) WITH CLUSTERING ORDER BY (data_hora DESC, id ASC) ;

COPY infobarbank.lancamentos_por_periodo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;

---------------------------------------------------------
--               LANCAMENTOS_POR_PRODUTO                      
---------------------------------------------------------
CREATE TABLE infobarbank.lancamentos_por_produto(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), id_produto, data_hora, id)
  ) WITH CLUSTERING ORDER BY (id_produto ASC, data_hora DESC, id ASC) ;

COPY infobarbank.lancamentos_por_produto (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;

---------------------------------------------------------
--               LANCAMENTOS_POR_TIPO                      
---------------------------------------------------------
CREATE TABLE infobarbank.lancamentos_por_tipo(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), tipo_lancamento, data_hora, id)
  ) WITH CLUSTERING ORDER BY (tipo_lancamento ASC, data_hora DESC, id ASC);

COPY infobarbank.lancamentos_por_tipo (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;

---------------------------------------------------------
--               LANCAMENTOS_DETALHE                     
---------------------------------------------------------
CREATE TABLE infobarbank.lancamentos_detalhe(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY(id));

COPY infobarbank.lancamentos_detalhe (id_cliente,competencia,data_hora,id_produto,status,tipo_lancamento,id,estabelecimento,valor)
  FROM './lancamentos_cc.csv' 
  WITH DELIMITER=',' AND HEADER=TRUE;
