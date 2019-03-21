$("#list-reports").on("contextmenu", ".report-infor", function (e) {
  e.preventDefault();
  $(".report-infor").removeClass("select-report");
  $(this).addClass("select-report");
  if ($(this).data("status") === "rejected") {
    superCm.createMenu(
      [
        {
          icon: "fa fa-eye c-blue-500",
          label: "<a href='" +
            Routes.trainee_report_path($(this).attr("id")) + "'>" +
            I18n.t("js.reports.view") + "</a>",
          submenu: null,
          disabled: false
        },
        {
          icon: "c-orange-500 fa fa-edit",
          label: "<a href='" +
            Routes.edit_trainee_report_path($(this).attr("id")) + "'>" +
            I18n.t("js.reports.edit") + "</a>",
          submenu: null,
          disabled: false
        },
        {
          icon: "c-red-500 fa fa-times",
          label: "<a href='" +
            Routes.trainee_report_path($(this).attr("id")) +
            "' data-method='delete' data-confirm='" +
            I18n.t("js.reports.confirm_delete") + "'>" +
            I18n.t("js.reports.delete") + "</a>",
          submenu: null,
          disabled: false
        },
      ], e);
  } else {
    superCm.createMenu(
      [
        {
          icon: "fa fa-eye c-blue-500",
          label: "<a href='" +
            Routes.trainee_report_path($(this).attr("id")) + "'>" +
            I18n.t("js.reports.view") + "</a>",
          submenu: null,
          disabled: false
        },
      ], e);
  }
});
