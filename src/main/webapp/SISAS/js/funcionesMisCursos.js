function showMessage(msg) {
    if (msg && msg !== "") {
        msg = $('<span/>').html(msg).text();
        alert(msg);
    }
}

// permite validar la session del usuario y si no es valida redirecciona al indice
function valSession() {
    var millisSession = $('input[name="millis"]').val();
    if (!millisSession || millisSession === "") {
        window.location.href = "../..";
        return false;
    }
    var d = new Date();
    var n = d.getTime();
    var r = n - millisSession;

    console.log('Tiempo restante de session: ' + r);

    if (r > 3600000) {
        alert('Se ha terminado la sesion');
        window.location.href = "/weblogin?tipo=SALIR";
        return false;
    }

    $.ajax({
        url: '/updateSession',
        type: 'POST'
    });
    return true;
}

function arrayToOptions(array) {
    var html = "<option value=''>Seleccione una opci&oacute;n</option>";
    for (key in array) {
        html += "<option value='" + key + "'>" + array[key] + "</option>";
    }
    return html;
}

//Las siguientes dos funciones permiten obtener un conjunto de datos desde una llamada a un servlet usando ajax
function getHtmlData(url, callback) {
    console.log(url);
    $.ajax({
        dataType: "html",
        url: url,
        success: function (data) {
            callback(data);
        },
        error: function (e) {
            console.log(e);
        }
    });
}

function getJSONData(url, callback) {
    console.log(url);
    $.ajax({
        dataType: "json",
        url: url,
        success: function (data) {
            callback(data);
        },
        error: function (e) {
            console.log(e);
        }
    });
}

//Permite preguntar al usuario si desea ontinuar antes de realizar una accion
function validate() {
    return confirm("Esta seguro que desea continuar?");
}

function goToCurso(cursoId, cursoName, tipoUser){
    window.location.href = "/setCurso?curso="+cursoId + "&cursoName="+cursoName + "&tipoUser=" + tipoUser;
}

function goToInformacionSelect() {
    window.location.href = "informacionEstudiante.jsp";
}

function main () {
    var msg = $('input[name="message"]').val();
    if (valSession()) {
        showMessage(msg);
        setTimeout(function () {
            $('#loading-content-panel').css('display', 'none');
            $('.primary-data-content').css('display', 'block');
        }, 1000);
    }
}

window.onload = main;