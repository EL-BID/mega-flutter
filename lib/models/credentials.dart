part of mega_flutter;

/// Esta classe é apenas uma base para novos tipos de credenciais.
/// Preferencialmente, deve-se criar novos tipos ao invés de modificar-lá.
/// Isso permite que cada projeto adapte-a às suas necessidades.
/// O exemplo a seguir mostrar como novos subtipos podem ser criados sem
/// modificar-lá:
/// ```
/// class DocumentCredentials extends Credentials {
//   String cpf;
//   String password;
//
//   DocumentCredentials(this.cpf, this.password);
// }
// ```
abstract class Credentials {}
