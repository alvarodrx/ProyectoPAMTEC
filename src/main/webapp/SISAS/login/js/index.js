var working = false;
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