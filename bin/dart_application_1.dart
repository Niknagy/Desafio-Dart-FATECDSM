import 'dart:io';
import 'dart:math';

void main() {
  bool executar = true;

  do {
    print('\n==================================================');
    print('   SISTEMA INTEGRADO DE EXERCÍCIOS - DART         ');
    print('==================================================');
    print('1. [Jogo 1] Adivinhe o Número (Conceitos: Variáveis e Laços)');
    print('2. [Jogo 2] Jokenpô / Pedra, Papel e Tesoura (Conceitos: Condicionais)');
    print('0. Sair do Sistema');
    print('==================================================');
    stdout.write('Escolha uma opção (0-2): ');
    
    String? entrada = stdin.readLineSync();
    
    switch (entrada) {
      case '1':
        adivinhe();
        break;
      case '2':
        jokenpo();
        break;
      case '0':
        print('\nEncerrando a aplicação... Até logo!');
        executar = false;
        break;
      default:
        print('\n[ERRO] Opção inválida! Digite um número de 0 a 2.');
    }

    if (executar) {
      print('\nPressione ENTER para voltar ao menu principal...');
      stdin.readLineSync();
    }

  } while (executar);
}

// ==========================================
// JOGO 1: Adivinhe o Número
// ==========================================

// Desafio 3: Criar uma Função Separada
// Alterado para int? para permitir o comando de "sair" do jogo
int? obterPalpiteValido() {
  while (true) {
    stdout.write('Digite seu palpite (ou "sair" para cancelar): ');
    final entrada = stdin.readLineSync()?.toLowerCase().trim();

    if (entrada == 'sair') {
      return null; 
    }

    // Validação básica de entrada original
    if (entrada == null || int.tryParse(entrada) == null) {
      print('Por favor, digite um número válido!');
      continue;
    }

    int palpite = int.parse(entrada);

    // Desafio 1: Tratamento de Limites (impede perda de tentativas)
    if (palpite < 1 || palpite > 100) {
      print('Número fora do intervalo! Tente um valor entre 1 e 100.');
      continue;
    }

    return palpite;
  }
}

void adivinhe() {
  // O computador escolhe um número aleatório entre 1 e 100
  final numeroSecreto = Random().nextInt(100) + 1;
  int tentativas = 0;
  int? palpite;

  print('=== BEM-VINDO AO JOGO DE ADIVINHAÇÃO ===');
  print('Tente adivinhar o número entre 1 e 100!');

  // Desafio 2: Modo Difícil com Limite (máximo de 7 tentativas)
  while (tentativas < 7) {
    palpite = obterPalpiteValido();

    // Condição para encerrar o jogo se o usuário digitar "sair"
    if (palpite == null) {
      print('Obrigado por jogar!');
      return; 
    }

    tentativas++;

    // Estruturas condicionais para dar dicas originais
    if (palpite < numeroSecreto) {
      print('Muito baixo! Tente um número maior.');
    } else if (palpite > numeroSecreto) {
      print('Muito alto! Tente um número menor.');
    } else {
      print('\n🎉 Parabéns! Você acertou em $tentativas tentativas.');
      return;
    }
  }

  // Se o laço quebrar e não for acerto, exibe o fim de jogo
  print('\nFim de Jogo! Você atingiu o limite de 7 tentativas.');
  print('O número correto era: $numeroSecreto');
}

// ==========================================
// JOGO 2: Jokenpô
// ==========================================

// Desafio 5: Uso de Enums (fortemente tipado)
enum Jogada { pedra, papel, tesoura }

void jokenpo() {
  print('=== BEM-VINDO AO JOKENPÔ ===');
  print('Opções válidas: pedra, papel ou tesoura.');

  // Desafio 4: Placar Acumulativo
  int vitoriasJogador = 0;
  int vitoriasComputador = 0;

  // Desafio 6: Melhor de Três (termina quando alguém faz 3 pontos)
  while (vitoriasJogador < 3 && vitoriasComputador < 3) {
    print('\nPlacar atual -> Você: $vitoriasJogador | Computador: $vitoriasComputador');
    stdout.write('Escolha sua jogada (ou digite "sair"): ');
    final entrada = stdin.readLineSync()?.toLowerCase().trim();

    // Condição para encerrar o jogo original
    if (entrada == 'sair') {
      print('Obrigado por jogar!');
      break;
    }

    // Convertendo a string para o Enum criado
    Jogada? jogadaJogador;
    if (entrada == 'pedra') jogadaJogador = Jogada.pedra;
    if (entrada == 'papel') jogadaJogador = Jogada.papel;
    if (entrada == 'tesoura') jogadaJogador = Jogada.tesoura;

    // Validação da entrada do usuário original
    if (jogadaJogador == null) {
      print('Jogada inválida! Escolha apenas pedra, papel ou tesoura.');
      continue;
    }

    // O computador escolhe um índice aleatório usando o Enum
    final indiceAleatorio = Random().nextInt(3);
    final jogadaComputador = Jogada.values[indiceAleatorio];

    print('Você escolheu: ${jogadaJogador.name}');
    print('O computador escolheu: ${jogadaComputador.name}');

    // Estrutura condicional para verificar o resultado
    if (jogadaJogador == jogadaComputador) {
      print('Empate! 🤝');
    } else if ((jogadaJogador == Jogada.pedra && jogadaComputador == Jogada.tesoura) ||
               (jogadaJogador == Jogada.papel && jogadaComputador == Jogada.pedra) ||
               (jogadaJogador == Jogada.tesoura && jogadaComputador == Jogada.papel)) {
      print('Você ganhou! 🎉');
      vitoriasJogador++; // Atualiza placar
    } else {
      print('O computador ganhou! 🤖');
      vitoriasComputador++; // Atualiza placar
    }
  }

  // Declaração do vencedor da melhor de três
  if (vitoriasJogador == 3) {
    print('\n🎉 Você venceu a melhor de três!');
  } else if (vitoriasComputador == 3) {
    print('\n🤖 O computador venceu a melhor de três!');
  }
}