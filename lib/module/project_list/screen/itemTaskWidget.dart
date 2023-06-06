import 'package:flutter/material.dart';

import '../../../configs/app_localizations.dart';
import '../../../configs/router.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/screen_util.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/color.dart';
import '../view_model/task_list_vm.dart';

class ItemTaskWidget extends StatefulWidget {
  final bool bookingStatus;
  final TaskInfo? taskInfo;
  final TaskListViewModel viewModel;
  final String? todoListType;

  ItemTaskWidget(
      this.bookingStatus, this.taskInfo, this.viewModel, this.todoListType);

  @override
  State<ItemTaskWidget> createState() => _ItemTaskWidgetState();
}

class _ItemTaskWidgetState extends State<ItemTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.viewModel.toDoListType == 'ListProcessingApproval') {
          ScreenUtils.openScreenWithData(context, AppRouter.detailTask, {
            "C_Approval_Request_Id": widget.taskInfo?.C_Approval_Request_Id,
            "ModuleName": widget.viewModel.moduleName,
            "TodoType": widget.viewModel.toDoListType,
            "RequestType": widget.taskInfo?.RequestType
          });
        } else {
          ScreenUtils.openScreenWithData(context, AppRouter.detailTaskWidget, {
            "C_Approval_Request_Id": widget.taskInfo?.C_Approval_Request_Id,
            "ModuleName": widget.viewModel.moduleName,
            "TodoType": widget.viewModel.toDoListType
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
            top: Dimens.size16, left: Dimens.size15, right: Dimens.size15),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: widget.viewModel.headerBorder),
                        color: AppColors.whiteColor),
                    padding: const EdgeInsets.only(
                        top: Dimens.size5,
                        bottom: Dimens.size5,
                        left: Dimens.size10,
                        right: Dimens.size10),
                    child: Center(
                        child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${widget.taskInfo?.Name}',
                              style: textStyleSmallBoldTitle,
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: AppColors.whiteColor),
                    padding: const EdgeInsets.only(
                        top: Dimens.size5,
                        bottom: Dimens.size5,
                        left: Dimens.size10,
                        right: Dimens.size10),
                    child: Center(
                        child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('don_vi_thuc_hien'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      '${widget.taskInfo?.OrgName}',
                                      style: textStyleTinyContent,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('Loai_yeu_cau'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      '${widget.taskInfo?.RequestTypeName}',
                                      style: textStyleTinyContent,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('ngay_yeu_cau'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      '${widget.taskInfo?.CreatedDate}',
                                      style: textStyleTinyContent,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('nguoi_gui'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      '${widget.taskInfo?.CreatedUser}',
                                      style: textStyleTinyContent,
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
