import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'week_total_payment_transactions.g.dart';

@JsonSerializable()
class WeekTotalPaymentTransactions extends Equatable {
  double? today;
  double? oneDayBefore;
  double? twoDaysBefore;
  double? threeDaysBefore;
  double? fourDaysBefore;
  double? fiveDaysBefore;
  double? sixDaysBefore;

  WeekTotalPaymentTransactions(
      {this.today,
        this.oneDayBefore,
        this.twoDaysBefore,
        this.threeDaysBefore,
        this.fourDaysBefore,
        this.fiveDaysBefore,
        this.sixDaysBefore});

  factory WeekTotalPaymentTransactions.fromJson(Map<String, dynamic> json) => _$WeekTotalPaymentTransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$WeekTotalPaymentTransactionsToJson(this);

  @override
  List<Object?> get props => [
    this.today,
    this.oneDayBefore,
    this.twoDaysBefore,
    this.threeDaysBefore,
    this.fourDaysBefore,
    this.fiveDaysBefore,
    this.sixDaysBefore
  ];
}