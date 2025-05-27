import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

@immutable
sealed class PaginationStateModel<T> {
  const PaginationStateModel([this.totalCount]);

  final int? totalCount;

  factory PaginationStateModel.fromException(dynamic l) {
    return PaginationStateError(
      l is GeneralException ? l.message : 'errorOccurred',
    );
  }

  factory PaginationStateModel.fromExceptionWithData(
    List<T> oldData,
    dynamic l, [
    int? totalCount,
  ]) {
    return PaginationStateErrorWithData(
      oldData,
      l is GeneralException ? l.message : 'errorOccurred',
      totalCount,
    );
  }

  const factory PaginationStateModel.initial() = PaginationStateInitial;

  const factory PaginationStateModel.success(
    List<T> data, [
    int? totalCount,
  ]) = PaginationStateSuccess;

  const factory PaginationStateModel.loading() = PaginationStateLoading;

  const factory PaginationStateModel.loadingWithData(
    List<T> oldData, [
    int? totalCount,
  ]) = PaginationStateLoadingWithData;

  const factory PaginationStateModel.error(
    String errorMessage,
  ) = PaginationStateError;

  const factory PaginationStateModel.errorWithData(
    List<T> oldData,
    String errorMessage, [
    int? totalCount,
  ]) = PaginationStateErrorWithData;
}

class PaginationStateInitial<T> extends PaginationStateModel<T> {
  const PaginationStateInitial();
}

class PaginationStateSuccess<T> extends PaginationStateModel<T> {
  final List<T> data;

  const PaginationStateSuccess(
    this.data, [
    super.totalCount,
  ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PaginationStateSuccess &&
          runtimeType == other.runtimeType &&
          DeepCollectionEquality.unordered().equals(data, other.data);

  @override
  int get hashCode => super.hashCode ^ data.hashCode;
}

class PaginationStateError<T> extends PaginationStateModel<T> {
  final String errorMessage;

  const PaginationStateError(this.errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PaginationStateError &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => super.hashCode ^ errorMessage.hashCode;
}

class PaginationStateLoading<T> extends PaginationStateModel<T> {
  const PaginationStateLoading();
}

class PaginationStateLoadingWithData<T> extends PaginationStateModel<T> {
  final List<T> oldData;

  const PaginationStateLoadingWithData(
    this.oldData, [
    super.totalCount,
  ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PaginationStateLoadingWithData &&
          runtimeType == other.runtimeType &&
          DeepCollectionEquality.unordered().equals(oldData, other.oldData);

  @override
  int get hashCode => super.hashCode ^ oldData.hashCode;
}

class PaginationStateErrorWithData<T> extends PaginationStateModel<T> {
  final String errorMessage;
  final List<T> oldData;

  const PaginationStateErrorWithData(
    this.oldData,
    this.errorMessage, [
    super.totalCount,
  ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PaginationStateErrorWithData &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage &&
          DeepCollectionEquality.unordered().equals(oldData, other.oldData);

  @override
  int get hashCode => super.hashCode ^ errorMessage.hashCode ^ oldData.hashCode;
}
