//= require rails-ujs
//= require jquery.min
//= require select2-full
//= require bootstrap.min
//= require cocoon

function initializeCampusSelect2() {
  $(".js-example-basic-single").each(function () {
    if ($(this).data("select2")) {
      $(this).select2("destroy");
    }
  });

  if ($(".js-example-basic-single").length === 0) {
    return;
  }

  $(".js-example-basic-single").select2({
    theme: "bootstrap",
    width: "100%",
    allowClear: true,
    placeholder: "Digite para buscar campus...",
    minimumInputLength: 0,
    minimumResultsForSearch: 0,

    ajax: {
      url: "/campus.json",
      dataType: "json",
      delay: 1000,

      data: function (params) {
        return {
          q: params.term || "",
          limit: 20,
        };
      },

      processResults: function (data) {
        return {
          results: data.results,
        };
      },

      cache: true,
    },

    language: {
      noResults: function () {
        return "Nenhum campus encontrado";
      },
      searching: function () {
        return "Procurando...";
      },
      inputTooShort: function () {
        return "Digite pelo menos 1 caractere";
      },
      errorLoading: function () {
        return "Erro ao carregar resultados";
      },
    },
  });
}

$(document).ready(function () {
  initializeCampusSelect2();
  initializeCampusSearchSelect2();
});

$(document).on("cocoon:after-insert", function () {
  initializeCampusSelect2();
});

// Função extra para separar da usada pelo formulário, para destacar o campus selecionado no index na tabela
function initializeCampusSearchSelect2() {
  $(".js-campus-search").select2({
    theme: "bootstrap",
    width: "100%",
    placeholder: "Buscar campus...",
    minimumInputLength: 1,
    ajax: {
      url: "/campus.json",
      dataType: "json",
      delay: 500,
      data: function (params) {
        return { q: params.term || "", limit: 20 };
      },
      processResults: function (data) {
        return { results: data.results };
      },
    },
  });

  $(".js-campus-search").on("select2:select", function (e) {
    var campusId = e.params.data.id;

    $(".table tbody tr").hide();

    var $row = $('tr[data-campus-id="' + campusId + '"]');

    if ($row.length) {
      $("tr").removeClass("table-warning");
      $row.show();
      $row.addClass("table-warning");

      $("html, body").animate(
        {
          scrollTop: $row.offset().top - 100,
        },
        500,
      );
    }
  });

  $(".js-campus-search").on("select2:clear select2:unselect", function () {
    $(".table tbody tr").show();
    $("tr").removeClass("table-warning");
  });
}
