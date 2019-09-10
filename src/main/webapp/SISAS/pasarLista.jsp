<html>
<head>
    <!--
    <%
        String message = "", millis = "", curso = "", cursoName = "";
        Object attr = session.getAttribute("message");
        if (attr != null)
            message = attr.toString();
        pageContext.setAttribute("message", message);

        attr = session.getAttribute("millis");
        if (attr != null)
            millis = attr.toString();
        pageContext.setAttribute("millis", millis);

        attr = session.getAttribute("curso");
        if (attr != null)
            curso = attr.toString();
        pageContext.setAttribute("curso", curso);

        attr = session.getAttribute("cursoName");
        if (attr != null)
            cursoName = attr.toString();
        pageContext.setAttribute("cursoName", cursoName);
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

        function goToCursoSelect() {
            window.location.href = "/SISAS/misCursos.jsp";
        }


    </script>
    <style>
        body, html {
            height: 100%;
            width: 100%;
            margin: 0px;
            font-family: Arial, serif;
            min-width: 800px;
            min-height: 600px;
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

        .mainMenuBar {
            z-index: 1;
        }

        .logo {
            height: 40px;
            width: available;
        }

        .ico-sm {
            width: 24px;
            height: 24px;
        }

        .dropdown-menu.show {
            display: block;
            text-align: end;
            width: max-content;
        }

        .overflow-scroll {
            overflow: scroll;
        }

    </style>

</head>
<div class="primary-data-content d-flex flex-column h-100 align-items-stretch">
    <body>
    <input type="hidden" id="millis" name="millis" value="${millis}">
    <input type="hidden" id="message" name="message" value="${message}">
    <input type="hidden" id="curso" name="curso" value="${curso}">
    <div id="mainMenuBar" class="mainMenuBar w-100 shadow">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="clearfix w-100" id="navbarColor02">
                <ul class="navbar-nav mr-auto float-left">
                    <li class="nav-item active">
                        <img src="imagenes/logoBlanco.png" class="img-fluid logo">
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0 float-right" action="/weblogin?tipo=SALIR">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                        <span class="align-top">Salir</span>
                        <i class="material-icons">exit_to_app</i>
                    </button>
                </form>
            </div>
        </nav>
        <div class="btn-group-vertical" style="width: 100%">
            <div class="btn-group btn-group-lg w-auto" role="group" aria-label="...">
                <button type="button" class="btn btn-outline-secondary border-0 bg-gray1 btn-lg"
                        onclick="goToCursoSelect();"
                        data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                    Mis cursos <i class="material-icons my-auto align-text-bottom">list_alt</i>
                </button>
                <div>
                    <h3 class="mt-2 ml-5">${cursoName}</h3>
                    <h4> Pasar Lista</h4>
                </div>
            </div>
            <div id="cursoBar" class="btn-group btn-group-lg bg-color1 buttonBar "
                 style="text-align: right; width: 100%;" role="group" aria-label="...">
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Asistencia <img class="img-fluid ico-sm" src="imagenes/asistencia.svg">
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                         aria-labelledby="dropdownMenuLista">
                        <a class="dropdown-item">Pasar lista
                            <img class="img-fluid ico-sm" src="imagenes/registrarAsistencia.svg">
                        </a>
                        <a class="dropdown-item" href="#">Modificar asistencia
                            <img class="img-fluid ico-sm" src="imagenes/editarAsistencia.svg">
                        </a>
                    </div>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Registro <img class="img-fluid ico-sm" src="imagenes/registro.svg">
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                         aria-labelledby="dropdownMenuLista">
                        <a class="dropdown-item">Action</a>
                        <a class="dropdown-item float-right" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Informaci&oacute;n <img class="img-fluid ico-sm" src="imagenes/informacion.svg">
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                         aria-labelledby="dropdownMenuLista">
                        <a class="dropdown-item">Action</a>
                        <a class="dropdown-item float-right" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Notas <img class="img-fluid ico-sm" src="imagenes/notas.svg">
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                         aria-labelledby="dropdownMenuLista">
                        <a class="dropdown-item">Action</a>
                        <a class="dropdown-item float-right" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-center overflow-scroll p-lg-4">

        <div class="overflow-scroll w-75 h-100 p-4">
            <!-- Ejemplo tabla-->
            <table class="table h-auto w-100">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">First</th>
                    <th scope="col">Last</th>
                    <th scope="col">Handle</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>

                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr>
                </tbody>
            </table>
            <!-- fin ejemplo -->
        </div>


    </div>
    </body>
</div>


<!--
<%@ include file="/loadingPage/loadingWrapper.jsp" %>
-->
</html>
