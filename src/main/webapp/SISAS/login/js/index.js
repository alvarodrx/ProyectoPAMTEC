var working = false;

function main () {

    var msg = $('input[name="message"]').val();
    document.getElementById('errormessage').innerHTML = msg;
    document.getElementById('errormessage-alert').innerHTML = msg;
    if (msg && msg !== "") {
        $('.alert').addClass("show");
        setTimeout(function () {
            $('.alert').removeClass("show");
        }, 3000);
    }

    $('.login').on('submit', function (e) {
        if (working) return;
        working = true;
        var $this = $(this),
            $state = $this.find('button > .state');
        $this.addClass('loading');
        $state.html('Autenticando');
        setTimeout(function () {
            $this.addClass('notok');
            $state.html('Espere...');
            setTimeout(function () {
                $state.html('Ingresar');
                $this.removeClass('notok loading');
                working = false;
            }, 2000);
        }, 10000);
    });
}

window.onload = main;