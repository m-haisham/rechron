/// Type alias representing a number value.
typedef NumberValue = Value<double>;

/// Type alias representing a duration value.
typedef DurationValue = Value<Duration>;

/// Type alias representing a datetime value.
typedef DateTimeValue = Value<DateTime>;

/// This represents a value in the rechron virtual machine
///
/// While the value uses generic [T] thus allowing potentially limitless
/// types of values. The only values that are actually supported/used are
/// [double], [Duration], and [DateTime] which correspond to the
/// type aliases [NumberValue], [DurationValue], and [DateTimeValue].
class Value<T> {
  const Value._(this.value);

  /// The wrapped data of the [Value]
  final T value;

  /// Create a new [NumberValue]
  static NumberValue number(double value) => Value._(value);

  /// Create a new [DurationValue]
  static DurationValue duration(Duration duration) => Value._(duration);

  /// Create a new [DateTimeValue]
  static DateTimeValue dateTime(DateTime dateTime) => Value._(dateTime);

  /// Implements multiplication for the types listed in [Value]
  ///
  /// Multiplication is implemented where the order is reversible between:
  ///
  /// - [NumberValue] and [NumberValue]
  /// - [NumberValue] and [DurationValue]
  ///
  /// # Errors
  ///
  /// This method will throw an [TypeError] when called on any other
  /// combination than mentioned above.
  Value operator *(Value other) {
    if (this is NumberValue) {
      final current = this as NumberValue;
      if (other is NumberValue) {
        final value = current.value * other.value;
        return Value.number(value);
      } else if (other is DurationValue) {
        final value = other.value * current.value;
        return Value.duration(value);
      }
    } else if (this is DurationValue && other is NumberValue) {
      final value = (this as DurationValue).value * other.value;
      return Value.duration(value);
    }

    throw TypeError();
  }

  /// Implements addition for the types listed above.
  ///
  /// Addition is implemented where the order is reversible between:
  ///
  /// - [DurationValue] and [DurationValue]
  /// - [DurationValue] and [DateTimeValue]
  ///
  /// # Errors
  ///
  /// This method will throw an [TypeError] when called on any other
  /// combination than mentioned above.
  Value operator +(Value other) {
    if (this is DurationValue) {
      if (other is DurationValue) {
        final duration = (this as DurationValue).value + other.value;
        return Value<Duration>._(duration);
      } else if (other is DateTimeValue) {
        final dateTime = other.value.add((this as DurationValue).value);
        return Value<DateTime>._(dateTime);
      }
    } else if (this is DateTimeValue && other is DurationValue) {
      final dateTime = (this as DateTimeValue).value.add(other.value);
      return Value<DateTime>._(dateTime);
    }

    throw TypeError();
  }

  /// Implements subtraction for the types listed above.
  ///
  /// Subtraction is implemented where the order is reversible between:
  ///
  /// - [DurationValue] and [DurationValue]
  /// - [DurationValue] and [DateTimeValue]
  ///
  /// # Errors
  ///
  /// This method will throw an [TypeError] when called on any other
  /// combination than mentioned above.
  Value operator -(Value other) {
    if (this is DurationValue) {
      if (other is DurationValue) {
        final duration = (this as DurationValue).value - other.value;
        return Value<Duration>._(duration);
      } else if (other is DateTimeValue) {
        final dateTime = other.value.subtract((this as DurationValue).value);
        return Value<DateTime>._(dateTime);
      }
    } else if (this is DateTimeValue && other is DurationValue) {
      final dateTime = (this as DateTimeValue).value.subtract(other.value);
      return Value<DateTime>._(dateTime);
    }

    throw TypeError();
  }

  @override
  String toString() => value.toString();
}
