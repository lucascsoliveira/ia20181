%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tabuleiro.pl                                                                                     %
%                                                                                                  %
% 	Um tabuleiro com um agente (A), um gol (G), alguns obstáculos (blocos). O exercício consiste   %
% em construir um programa Prolog para encontrar um caminho do agente até o gol. A solução é a     %
% lista de posições que constituem o caminho da posição inicial do agente até o gol. O tabuleiro   %
% tem uma dimensão (qtde. de linhas e colunas) qualquer e os objetos (agente, gol e blocos) estão  %
% distribuídos aleatoriamente no tabuleiro. Pede-se um caminho qualquer que leve o agente ao gol.  %
% Deve haver uma separação lógica entre as informações do ambiente e as informações do agente.     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxLinha(4).
maxColuna(8).

pos_agente(2,1).
pos_gol(3,8).

bloco(1,7).
bloco(2,3).
bloco(2,6).
bloco(3,4).
bloco(4,6).

pos_livre(X, Y):- \+bloco(X, Y).

pos_valida(X, Y):- maxLinha(XM) , X > 0, X =< XM,
                   maxColuna(YM), Y > 0, Y =< YM.

membro(X, [X|_]).
membro(X, [_|R]):- membro(X,R).

nao_membro(X, Y):- \+membro(X,Y).

% inverter([], []).
% inverter(L, L).

agente([X,Y|[]], PosVisitadas, [[X,Y]|PosVisitadas]):- pos_gol(X,Y).
agente([X,Y|[]], PosVisitadas, Caminho):- 
    pos_valida(X,Y), pos_livre(X,Y), nao_membro([X,Y], PosVisitadas),
    %format('Visitando [~p,~p]~n', [X,Y]),
    (
    	(X1 is X - 1, agente([X1,Y], [[X,Y]|PosVisitadas], Caminho)); % CIMA
    	(Y1 is Y + 1, agente([X,Y1], [[X,Y]|PosVisitadas], Caminho)); % DIREITA
    	(X1 is X + 1, agente([X1,Y], [[X,Y]|PosVisitadas], Caminho)); % ESQUERDA
    	(Y1 is Y - 1, agente([X,Y1], [[X,Y]|PosVisitadas], Caminho))  % BAIXO
    ).

agente(Caminho):- pos_agente(X,Y), agente([X,Y],[], Caminho).


