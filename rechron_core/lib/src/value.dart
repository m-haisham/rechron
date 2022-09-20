typedef NumberValue = Value<double>;
typedef DurationValue = Value<Duration>;
typedef DateTimeValue = Value<DateTime>;

class Value<T> {
  const Value._(this.value);

  final T value;

  static NumberValue number(double value) => Value._(value);
  static DurationValue duration(Duration duration) => Value._(duration);
  static DateTimeValue dateTime(DateTime dateTime) => Value._(dateTime);

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

  Value operator +(Value other) {
    if (this is DurationValue && other is DurationValue) {
      final current = this as DurationValue;
      final value = current.value + other.value;
      return Value.duration(value);
    }

    throw TypeError();
  }

  @override
  String toString() => value.toString();
}
