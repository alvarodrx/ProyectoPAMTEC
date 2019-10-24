function showMessage(msg) {
    if (msg && msg !== "") {
        alert(msg);
    }
}

//Esta funcion se ejecuta al puro inicio, permite verificar la sesion o si hay un mensaje desde la llamada
jQuery(document).ready(function () {
    var msg = $('input[name="message"]').val();
    if (valSession() && valCurso()) {
        showMessage(msg);
        setTimeout(function () {
            $('#loading-content-panel').css('display', 'none');
            $('.primary-data-content').css('display', 'block');
        }, 1000);

    }


});

function setInfoSelect(){

}

//Valida que se haya ingresado con un curso definido, de no ser asi, devuelve a la seleccion de curso
function valCurso() {
    var curso = $('input[name="curso"]').val();
    if (!curso || curso === "") {
        alert('Debes escoger un curso.');
        goToCursoSelect();
        return false;
    }
    return true;
}

// permite validar la session del usuario y si no es valida redirecciona al indice
function valSession() {
    var millisSession = $('input[name="millis"]').val();
    if (!millisSession || millisSession === "") {
        window.location.href = "/SISAS/login/";
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

//Permite preguntar al usuario si desea continuar antes de realizar una accion
function validate() {
    return confirm("Esta seguro que desea continuar?");
}

//Permite obtener el id de un estudiante seleccionado
function getDataEstudiantePAM() {
    var  cedulaEstudiantePAM = $("select[name = 'estudiantePAM']").val();
    document.getElementById("cedulaEstudiante").innerHTML = cedulaEstudiantePAM;
}

//P
function getYearCurso(){
    var cursoSelect = $('select[name="cursoSelect"]').val();
    var annoSelect= $('select[name="annoSelect"]');
    getHtmlData(
        "/getYearCursoAdmiServlet?cursoSelect="+cursoSelect,
        function (data) {
            var i, len, text;
            var html = "<option value=''>A&ntilde;o</option>";
            annoSelect.html(html + data);
        }

    );
}

function getSemesterYearCurso(){
    var cursoSelect = $('select[name="cursoSelect"]').val();
    var annoSelect= $('select[name="annoSelect"]').val();
    var semestreSelect = $('select[name="semestreSelect"]');
    getHtmlData(
        "/getSemestresCursoAdmiServlet?cursoSelect="+cursoSelect+"&annoSelect="+annoSelect,
        function (data) {
            var i, len, text;
            var html = "<option value=''>Semestre</option>";
            semestreSelect.html(html + data);
        }

    );
}
//
function getGruposSemesterYearCurso(){
    var cursoSelect = $('select[name="cursoSelect"]').val();
    var annoSelect= $('select[name="annoSelect"]').val();
    var semestreSelect = $('select[name="semestreSelect"]').val();
    var gruposSelect = $('select[name="gruposSelect"]');
    getHtmlData( "/getGruposAdminServlet?cursoSelect="+cursoSelect+"&annoSelect="+annoSelect+"&semestreSelect="+semestreSelect,
        function (data) {
            var i, len, text;
            var html = "<option value=''>Grupo</option>";
            gruposSelect.html(html + data);
        }

    );
}

function getNotasGrupoAdmin(){
    var gruposSelect = $('select[name="gruposSelect"]').val();
    var tablaCuerpo = $('#cuerpoTabla');
    getHtmlData( "/getNotasCursoServlet?curso="+gruposSelect,
        function (data) {
            var i, len, text;
            tablaCuerpo.html(data);

        }

    );
}

function getGruposActualesCurso(){
    var cursoSelect = $('select[name="cursoSelect"]').val();
    var gruposActuales = $('select[name="gruposActualesSelect"]');

    getHtmlData( "/getGruposActualesCursosServlet?curso="+cursoSelect,
        function (data) {
            var i, len, text;
            var html = "<option value=''>Grupos del curso</option>";
            gruposActuales.html(html+data);

        }

    );
}

function getListaEstudiantesAdmi(){
    var gruposActual = $('select[name="gruposActualesSelect"]').val();
    var estPAMSelect = $('select[name="estudiantePAM"]');
    getHtmlData( "/getStudentsAdminServlet?curso="+gruposActual,
        function (data) {
            var i, len, text;
            var html = "<option value='' >Nombre del estudiante PAM</option>";
            estPAMSelect.html(html+data);

        }

    );
}

function getGruposEstudiantesAdmi(){
    var estPAMSelect = $('select[name="estudiantePAM"]').val();
    var gruposSelect = $('select[name="gruposActualesSelect"]');
    getHtmlData( "/getGruposEstudiantePAMServelt?estudiantePAM="+estPAMSelect ,
        function (data) {
            var i, len, text;
            var html = " <option value='' >Grupos de Estudiante PAM</option>";
            gruposSelect.html(html+data);
        }

    );

}

function getInfoGrupo(){
    var gruposSelect = $('select[name="gruposActualesSelect"]').val();
    var diveTextAsis = $('#idAsistenteInfo');
    var diveTextGroup = $('#grupoInfo');
    getHtmlData( "/getInfoCurso?curso="+gruposSelect ,
        function (data) {
            var i, len, text;
            diveTextGroup.html(data);
        }
    );
    getHtmlData( "/getInfoCursoAsistentes?curso="+gruposSelect ,
        function (data) {
            var i, len, text;
            diveTextAsis.html(data);
        }
    );

}



