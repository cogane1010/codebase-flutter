import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/date_time.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../view_model/task_list_vm.dart';

class ItemAdjustTaskWidget extends StatefulWidget {
  final bool bookingStatus;
  final TaskInfo? taskInfo;
  final TaskListViewModel viewModel;
  final String? todoListType;

  ItemAdjustTaskWidget(
      this.bookingStatus, this.taskInfo, this.viewModel, this.todoListType);

  @override
  State<ItemAdjustTaskWidget> createState() => _ItemTaskWidgetState();
}

class _ItemTaskWidgetState extends State<ItemAdjustTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: Dimens.size10,
                right: Dimens.size10,
                bottom: Dimens.size10,
                top: Dimens.size10),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: UiHelper.borderRadiusTopLeftRight,
                border: Border(
                    left: BorderSide(width: 1, color: AppColors.approveButton),
                    top: BorderSide(width: 1, color: AppColors.approveButton),
                    right: BorderSide(width: 1, color: AppColors.approveButton),
                    bottom:
                        BorderSide(width: 1, color: AppColors.approveButton))),
            child: Text(
              !isEmpty(widget.taskInfo) ? widget.taskInfo!.Name.toString() : "",
              style: textStyleSmallContent,
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: Dimens.size10,
                  right: Dimens.size10,
                  bottom: Dimens.size10,
                  top: Dimens.size10),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1, color: AppColors.grayTextColor3),
                    top: BorderSide(width: 1, color: AppColors.grayTextColor3),
                    right:
                        BorderSide(width: 1, color: AppColors.grayTextColor3),
                    bottom:
                        BorderSide(width: 1, color: AppColors.grayTextColor3)),
                borderRadius: UiHelper.borderRadiusbottomLeftRight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    !isEmpty(widget.taskInfo)
                        ? AppLocalizations.of(context)!
                                .translate('don_vi_thuc_hien') +
                            ":   " +
                            "${widget.taskInfo!.AssignedOrgName.toString()}"
                        : "",
                    style: textStyleSmallContent,
                  ),
                  Text(
                    !isEmpty(widget.taskInfo)
                        ? AppLocalizations.of(context)!
                                .translate('ngay_bat_dau') +
                            ":   " +
                            "${DateTimeUtils.convertToString(widget.taskInfo!.OldStartDate)}"
                        : "",
                    style: textStyleSmallContent,
                  ),
                  Text(
                    !isEmpty(widget.taskInfo)
                        ? AppLocalizations.of(context)!
                                .translate('han_hoan_thanh') +
                            ":   " +
                            "${DateTimeUtils.convertToString(widget.taskInfo!.OldDeadline)}"
                        : "",
                    style: textStyleSmallContent,
                  ),
                  Text(
                    !isEmpty(widget.taskInfo)
                        ? AppLocalizations.of(context)!
                                .translate('ngay_bat_dau_dieu_chinh') +
                            ":   " +
                            "${DateTimeUtils.convertToString(widget.taskInfo!.StartDate)}"
                        : "",
                    style: textStyleblackBoldContent,
                  ),
                  Text(
                    !isEmpty(widget.taskInfo)
                        ? AppLocalizations.of(context)!
                                .translate('han_hoan_thanh_dieu_chinh') +
                            ":   " +
                            "${DateTimeUtils.convertToString(widget.taskInfo!.Deadline)}"
                        : "",
                    style: textStyleblackBoldContent,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
