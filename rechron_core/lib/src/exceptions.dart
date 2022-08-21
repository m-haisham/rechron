/// Base exception interface intended to be implemented by all
/// library exceptions.
abstract class RechronException implements Exception {
  const RechronException();
}

/// Raised when unable to parse date string.
class CompileException implements RechronException {
  const CompileException();
}

/// Raised when vm encounters a runtime error.
class RuntimeException implements RechronException {
  const RuntimeException();
}

/// Raised when last item of vm stack is not datetime.
class UnexpectedResultException implements RechronException {
  const UnexpectedResultException();
}
