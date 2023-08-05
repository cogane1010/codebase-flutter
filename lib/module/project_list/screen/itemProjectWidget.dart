import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/module/project_list/view_model/project_list_vm.dart';
import 'package:flutter/material.dart';

import '../../../configs/app_localizations.dart';
import '../../../configs/router.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/screen_util.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/color.dart';

class ItemProjectWidget extends StatefulWidget {
  final bool bookingStatus;
  final ProjectInfo? projectInfo;
  final ProjectListViewModel viewModel;

  ItemProjectWidget(this.bookingStatus, this.projectInfo, this.viewModel);

  @override
  State<ItemProjectWidget> createState() => _ItemProjectWidgetState();
}

class _ItemProjectWidgetState extends State<ItemProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScreenUtils.openScreenWithData(context, AppRouter.detailProject, {
          "C_Approval_Request_Id": widget.projectInfo?.C_Approval_Request_Id,
          "TodoType": widget.viewModel.toDoListType,
          "ModuleName": widget.viewModel.moduleName
        });
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
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: widget.viewModel.headerBorder),
                        color: AppColors.whiteColor),
                    padding: const EdgeInsets.only(
                        top: Dimens.size8,
                        bottom: Dimens.size5,
                        left: Dimens.size10,
                        right: Dimens.size10),
                    child: Center(
                        child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${widget.projectInfo?.Name}',
                              style: textStyleSmallBoldTitle,
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                  Container(
                    height: 70,
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
                                          .translate('ma'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      '${widget.projectInfo?.Code}',
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
                                          .translate('loai'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      !isEmpty(widget.projectInfo?.ProjectType)
                                          ? '${widget.projectInfo?.ProjectType}'
                                          : "",
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
                                          .translate('don_vi_thuc_hien'),
                                      style: textStyleTinyContent,
                                    )),
                                UiHelper.horizontalBox8,
                                Expanded(
                                    flex: 6,
                                    child: Text(
                                      !isEmpty(widget.projectInfo?.lstOrgName)
                                          ? '${widget.projectInfo?.lstOrgName}'
                                          : "",
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
