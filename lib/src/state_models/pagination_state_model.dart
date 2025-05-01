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
    dynamic l,
  ) {
    return PaginationStateErrorWithData(
      oldData,
      l is GeneralException ? l.message : 'errorOccurred',
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
}

class PaginationStateError<T> extends PaginationStateModel<T> {
  final String errorMessage;

  const PaginationStateError(this.errorMessage);
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
}

class PaginationStateErrorWithData<T> extends PaginationStateModel<T> {
  final String errorMessage;
  final List<T> oldData;

  const PaginationStateErrorWithData(
    this.oldData,
    this.errorMessage, [
    super.totalCount,
  ]);
}
