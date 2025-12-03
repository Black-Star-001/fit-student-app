class ConsentState {
  final bool acceptedTerms;
  final bool acceptedPrivacyPolicy;

  ConsentState({
    this.acceptedTerms = false,
    this.acceptedPrivacyPolicy = false,
  });

  // Estado inicial (usuário ainda não aceitou nada)
  factory ConsentState.initial() {
    return ConsentState(
      acceptedTerms: false,
      acceptedPrivacyPolicy: false,
    );
  }

  // Helper para verificar se todos os obrigatórios foram aceitos
  bool get isValid => acceptedTerms && acceptedPrivacyPolicy;

  // Método para atualizar o estado mantendo a imutabilidade
  ConsentState copyWith({
    bool? acceptedTerms,
    bool? acceptedPrivacyPolicy,
  }) {
    return ConsentState(
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      acceptedPrivacyPolicy: acceptedPrivacyPolicy ?? this.acceptedPrivacyPolicy,
    );
  }
}