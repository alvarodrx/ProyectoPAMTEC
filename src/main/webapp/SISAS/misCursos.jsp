<html>
<head>
    <!--
    <%
        String message = "", millis = "";
        Object attr = session.getAttribute("message");
        if (attr != null)
            message = attr.toString();
        pageContext.setAttribute("message", message);

        attr = session.getAttribute("millis");
        if (attr != null)
            millis = attr.toString();
        pageContext.setAttribute("millis", millis);
    %>
    -->
    <title>SISAS</title>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/cosmos.min.css">

    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

    <script type="text/javascript">
        function showMessage(msg) {
            if (msg && msg !== "") {
                msg = $('<span/>').html(msg).text();
                alert(msg);
            }
        }

        //Esta funcion se ejecuta al puro inicio, permite verificar la sesion o si hay un mensaje desde la llamada
        jQuery(document).ready(function () {
            var msg = $('input[name="message"]').val();
            if (valSession()) {
                showMessage(msg);
                setTimeout(function () {
                    $('#loading-content-panel').css('display', 'none');
                    $('#primary-data-content').css('display', 'block');
                }, 1000);
            }


        });


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

        //Permite preguntar al usuario si desea ontinuar antes de realizar una accion
        function validate() {
            return confirm("Esta seguro que desea continuar?");
        }

        function goToCurso(cursoId, cursoName){
            window.location.href = "/setCurso?curso="+cursoId + "&cursoName="+cursoName;
        }


    </script>

    <style>
        body, html {
            height: 100%;
            width: 100%;
            margin: 0px;
            font-family: Arial, serif;
        }

        .wrapper {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            position: absolute;
            right: 0;
            left: 0;
            top: 0;
            bottom: 0;
            background: #36a9daaa;
            z-index: 0;
        }
        .navbar{
            z-index: 1;
        }
        .logo {
            height: 40px;
        }
        tr{
            cursor: pointer;
        }
    </style>


</head>
<body>
<input type="hidden" id="millis" name="millis" value="${millis}">
<input type="hidden" id="message" name="message" value="${message}">
<input type="hidden" id="curso" name="curso" value="${curso}">
<div class="primary-data-content">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <img src="imagenes/logoBlanco.png" class="img-fluid logo">
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0" action="/weblogin?tipo=SALIR">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                    <span class="align-top">Salir</span>
                    <i class="material-icons">exit_to_app</i>
                </button>
            </form>
        </div>
    </nav>

    <div class="wrapper">
        <div class="card bg-light mb-3 rounded-lg shadow" >
            <div class="card-body" style="display: block; width: 400px; max-height: 400px;">
                <h2 class="card-title mx-auto" style="text-align: center"><b>Mis cursos</b></h2>
                <br>
                <div class="table-responsive" style="max-height: 280px;overflow-y: scroll;">
                    <table class="table table-hover">
                        <tbody>
                        <tr class="table-dark" onclick="goToCurso(1, 'Curso 1');">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 1</td>
                        </tr>
                        <tr class="table-light" onclick="goToCurso(2, 'Curso 2');">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 2</td>
                        </tr>
                        <tr class="table-dark">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 1</td>
                        </tr>
                        <tr class="table-light">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 2</td>
                        </tr>
                        <tr class="table-dark">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 1</td>
                        </tr>
                        <tr class="table-light">
                            <td scope="row">
                                <i class="material-icons">
                                    list_alt
                                </i>
                            </td>
                            <td>Curso 2</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


    </div>

</div>
</body>
<%@ include file="/loadingPage/loadingWrapper.jsp" %>

</html>
