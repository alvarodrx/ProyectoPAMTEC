<%@ page import="java.time.LocalDate" %>
<html>
<head>
    <!--
    <%
        String message = "", millis = "", curso = "", cursoName = "", usuario = "", tipoUsuario = "";
        Object attr = session.getAttribute("message");
        if (attr != null)
            message = attr.toString();
        pageContext.setAttribute("message", message);
        attr = session.getAttribute("millis");
        if (attr != null)
            millis = attr.toString();
        pageContext.setAttribute("millis", millis);
        session.removeAttribute("message");
        attr = session.getAttribute("tipoUsuario");
        if (attr != null)
            tipoUsuario = attr.toString();
        pageContext.setAttribute("tipoUsuario", tipoUsuario);
        if (tipoUsuario == null || !tipoUsuario.equals("1")){
            session.setAttribute("message", "Debe tener permisos de administrador para ingresar al sitio solicitado.");
            response.sendRedirect("/SISAS/login/");
        }
        attr = session.getAttribute("usuario");
        if (attr != null)
            usuario = attr.toString();
        pageContext.setAttribute("usuario", usuario);

        pageContext.setAttribute("curso", -1);

        pageContext.setAttribute("cursoName", "Administrador");


        String currentDateTime = LocalDate.now().toString();
        pageContext.setAttribute("currentDateTime", currentDateTime);
    %>
    -->
    <title>SISAS</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/cosmos.min.css">

    <!-- Favicons -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="apple-touch-icon">


    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/SISAS/js/xepOnline.jqPlugin.js"></script>


    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

        function crearGrafico1() {
            var semestreSelect = $('#selectSemestre').val();
            if (semestreSelect === "") {
                alert("Debe seleccionar un semestre");
                return false;
            }
            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages': ['corechart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart1);
        }

        // Callback that creates and populates a data table,
        // instantiates the pie chart, passes in the data and
        // draws it.
        <!-- This adds the proper namespace on the generated SVG -->
        function AddNamespace1() {
            var svg = $('#chart1_div svg');
            svg.attr("xmlns", "http://www.w3.org/2000/svg");
            svg.css('overflow', 'visible');
        }

        function AddNamespace2() {
            var svg = $('#chart2_div svg');
            svg.attr("xmlns", "http://www.w3.org/2000/svg");
            svg.css('overflow', 'visible');
        }

        function AddNamespace2_1() {
            var svg = $('#chart2_1_div svg');
            svg.attr("xmlns", "http://www.w3.org/2000/svg");
            svg.css('overflow', 'visible');
        }

        function AddNamespace3() {
            var svg = $('#chart3_div svg');
            svg.attr("xmlns", "http://www.w3.org/2000/svg");
            svg.css('overflow', 'visible');
        }

        <!-- This generates the google chart -->
        function drawChart1() {
            var semestreSelect = $('#selectSemestre').val();
            getJSONData("/getChartData?tipo=CHART1&semestre=" + semestreSelect,
                function (data) {
                    var dataChart = google.visualization.arrayToDataTable([
                        ['Genero', 'Matriculas por semestre'],
                        ['Hombres', data.Hombres],
                        ['Mujeres', data.Mujeres]
                    ]);

                    var options = {
                        title: 'Matriculas por genero: ' + semestreSelect
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('chart1_div'));
                    google.visualization.events.addListener(chart, 'ready', AddNamespace1);
                    chart.draw(dataChart, options);
                });

        }

        function crearGrafico2() {
            var semestreSelect = $('#selectSemestre2').val();
            if (semestreSelect === "") {
                alert("Debe seleccionar un semestre");
                return false;
            }
            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages': ['corechart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart2);
        }

        <!-- This generates the google chart -->
        function drawChart2() {
            var semestreSelect = $('#selectSemestre2').val();
            getJSONData("/getChartData?tipo=CHART2&semestre=" + semestreSelect,
                function (data) {
                    var dataChart = google.visualization.arrayToDataTable([
                        ['Estado', 'Cupos matriculados vs abandonados'],
                        ['Cupos matriculados', data.Activos],
                        ['Abandonos', data.Abandonos]
                    ]);

                    var options = {
                        title: 'Cupos matriculados vs abandonados: ' + semestreSelect
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('chart2_div'));
                    google.visualization.events.addListener(chart, 'ready', AddNamespace2);
                    chart.draw(dataChart, options);
                    crearGrafico2_1();
                });

        }
        function crearGrafico2_1() {
            var semestreSelect = $('#selectSemestre2').val();
            if (semestreSelect === "") {
                alert("Debe seleccionar un semestre");
                return false;
            }
            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages':['corechart', 'bar']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart2_1);
        }

        <!-- This generates the google chart -->
        function drawChart2_1() {
            var semestreSelect = $('#selectSemestre2').val();
            getJSONData("/getChartData?tipo=CHART2_1&semestre=" + semestreSelect,
                function (data) {
                    var dataChart = google.visualization.arrayToDataTable(data);

                    var options = {
                        chart: {
                            width: 400,
                            title: 'Cupos matriculados vs abandonados por grupo: ' + semestreSelect,
                        }
                    };


                    var chart = new google.visualization.ColumnChart(document.getElementById('chart2_1_div'));
                    google.visualization.events.addListener(chart, 'ready', AddNamespace2_1);
                    chart.draw(dataChart, google.charts.Bar.convertOptions(options));
                });

        }

        function crearGrafico3() {
            var semestreSelect = $('#selectSemestre3').val();
            if (semestreSelect === "") {
                alert("Debe seleccionar un semestre");
                return false;
            }
            // Load the Visualization API and the corechart package.
            google.charts.load('current', {'packages': ['corechart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart3);
        }

        <!-- This generates the google chart -->
        function drawChart3() {
            var semestreSelect = $('#selectSemestre3').val();
            getJSONData("/getChartData?tipo=CHART3&semestre=" + semestreSelect,
                function (data) {
                    var dataChart = google.visualization.arrayToDataTable([
                        ['Estado', 'Matriculas vs abandonos al programa'],
                        ['Matriculas realizadas', data.Activos],
                        ['Abandonos al programa', data.Abandonos]
                    ]);

                    var options = {
                        title: 'Matriculas vs abandonos al programa: ' + semestreSelect
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('chart3_div'));
                    google.visualization.events.addListener(chart, 'ready', AddNamespace3);
                    chart.draw(dataChart, options);
                });

        }

        function downloadCsv(chart) {
            var url;
            var semestreSelect;
            if (chart === 1) {
                semestreSelect = $('#selectSemestre').val();
                url = '/getChartData?tipo=CHART1_DOWNLOAD&semestre=' + semestreSelect;
            }
            if (chart === 2) {
                semestreSelect = $('#selectSemestre2').val();
                url = '/getChartData?tipo=CHART2_DOWNLOAD&semestre=' + semestreSelect;
            }
            if (semestreSelect === "") {
                alert("Debe seleccionar un semestre");
                return false;
            }
            window.location.href = url;

        }
    </script>

    <script src="${pageContext.request.contextPath}/SISAS/js/transiciones.js"></script>
    <script src="${pageContext.request.contextPath}/SISAS/js/funciones.js"></script>
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

        /*    */

        #buttons button:first-child {
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
        }

        #buttons buttons button:last-child {
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
        }

        #buttons button {
            color: #111;
            background-image: linear-gradient(to bottom, #ffffff 0, #777777 100%);
            background-repeat: repeat-x;
            padding: 5px 10px;
            font-size: 12px;
            line-height: 1.5;
            cursor: pointer;
            border-width: 1px;
            border-color: #777;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, .1);
            box-shadow: inset 0 1px 0 rgba(255, 255, 255, .15), 0 1px 1px rgba(0, 0, 0, .075);
        }

        #buttons button:hover {
            color: #fff;
            background-image: linear-gradient(to top, #337ab7 0, #265a88 100%);
        }

        .chart_div {
            display: inline-block;
            margin: 0 auto;
            height: 400px;
        }

    </style>

</head>
<%@ include file="/loadingPage/loadingWrapper.jsp" %>
<body>
<div class="primary-data-content d-flex flex-column h-100">
    <input type="hidden" id="millis" name="millis" value="${millis}">
    <input type="hidden" id="message" name="message" value="${message}">
    <input type="hidden" id="usuario" name="usuario" value="${usuario}">
    <input type="hidden" id="usuario" name="curso" value="${curso}">
    <input type="hidden" id="tipoUsuario" name="tipoUsuario" value="${tipoUsuario}">
    <div id="mainMenuBar" class="mainMenuBar w-100 shadow position-fixed">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="clearfix w-100 text-center" id="navbarColor02">
                <ul class="navbar-nav mr-auto float-left">
                    <li class="nav-item active">
                        <img src="../imagenes/logoBlanco.png" class="img-fluid logo">
                    </li>
                </ul>
                <span style="color:white; font-size:24px;">
                        <i class="material-icons" style="vertical-align: sub;"> person_outline </i> ${usuario}
                </span>
                <form class="form-inline my-auto float-right" action="/weblogin">
                    <input type="hidden" name="tipo" value="SALIR">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                        <span class="align-top">Salir</span>
                        <i class="material-icons">exit_to_app</i>
                    </button>
                </form>
            </div>
        </nav>
        <div class="btn-group-vertical bg-white" style="width: 100%">
            <div class="btn-group btn-group-lg w-auto" role="group" aria-label="...">
                <button type="button" class="btn btn-outline-secondary border-0 bg-gray1 btn-lg"
                        onclick="#"
                        data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                    ${usuario}
                </button>
                <div>
                    <h3 class="mt-2 ml-5">Administrador SISAS | Estadisticas</h3>
                </div>
            </div>
            <div id="cursoBar" class="btn-group btn-group-lg bg-color1 buttonBar "
                 style="text-align: right; width: 100%;" role="group" aria-label="...">
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Estudiantes PAM <img class="img-fluid ico-sm" src="../imagenes/estudiantesPAM.svg">
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                         aria-labelledby="dropdownMenuLista">
                        <a href="javascript:goToModificarAsistenciaAdmin();" class="dropdown-item">Editar Asistencia
                            <img class="img-fluid ico-sm" src="../imagenes/editarAsistencia.svg">
                        </a>
                        <a class="dropdown-item" href="javascript:goToRegistrarLlamadaAdmin()">Registrar llamada
                            <img class="img-fluid ico-sm" src="../imagenes/llamada.svg">
                        </a>
                        <a href="javascript:goToRegistrarAbandonoAdmin();" class="dropdown-item">Registrar abandono
                            <img class="img-fluid ico-sm" src="../imagenes/abandono.svg">
                        </a>
                        <a class="dropdown-item" href="javascript:goToInformacionEstudiantesAdmin()">Estudiante PAM
                            <img class="img-fluid ico-sm" src="../imagenes/registro.svg">
                        </a>
                    </div>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false"
                            onclick="goToInformacionCursosAdmin()">
                        Info. Cursos <img class="img-fluid ico-sm" src="../imagenes/cursoInfo.svg">
                    </button>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                        Estadisticas <img class="img-fluid ico-sm" src="../imagenes/statistics.svg">
                    </button>
                </div>
                <div class="dropdown">
                    <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false"
                            onclick="goToPermisos()">
                        Permisos <img class="img-fluid ico-sm" src="../imagenes/key.svg">
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="charts-content" class="w-100 text-center p-3" style="margin-top: 160px;">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="tab1-tab" data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1"
                   aria-selected="true">Matricula por g&eacute;nero</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab2-tab" data-toggle="tab" href="#tab2" role="tab" aria-controls="profile"
                   aria-selected="false">Cupos matriculados vs abandonos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab3-tab" data-toggle="tab" href="#tab3" role="tab" aria-controls="profile"
                   aria-selected="false">Matricula vs abandono al programa</a>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="tab1" role="tabpanel" aria-labelledby="tab1-tab">
                <div class="form-group w-25 mx-auto my-2">
                    <label for="selectSemestre">Seleccione un semestre:</label>
                    <select class="custom-select custom-select-sm" id="selectSemestre">
                        <option value=""></option>
                        <jsp:include page="/getFilterData">
                            <jsp:param name="tipo" value="SEMESTRES"/>
                        </jsp:include>
                    </select>
                    <br>
                    <button type="button" class="btn btn-secondary my-3" onclick="crearGrafico1();">Generar gr&aacute;fico</button>
                </div>
                <div id="chart1-space" class="w-100">
                    <header style="display:none; margin-top:24px;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td style="text-align:center;">
                                    <p>Tecnol&oacute;gico de Costa Rica</p>
                                </td>
                                <td style="text-align:center;">
                                    <p>Centro de Vinculaci&oacute;n</p>
                                </td>
                                <td style="text-align:right;">
                                    <p>SISAS PAMTEC</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </header>
                    <footer style="display:none;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td>
                                    <p></p>
                                </td>
                                <td style="text-align:center;">
                                    <p>${currentDateTime}</p>
                                </td>
                                <td style="text-align:right">
                                    <p>Page
                                        <pagenum></pagenum>
                                        of
                                        <totpages></totpages>
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </footer>
                    <div>
                        <br><br><br>
                        <h5>Proyecto Educativo para la Persona Adulta Mayor - PAMTEC</h5>
                        <br>
                        <h6>Estad&iacute;sticas - Matr&iacute;cula por g&eacute;nero</h6>
                        <br><br><br>
                    </div>
                    <div id="chart1_div" class="w-75 chart_div mx-auto">
                        <p>No se ha generado el gr&aacute;fico.</p>
                    </div>
                </div>
                <hr/>
                <div id="" class="">
                    <div class="dropdown ">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="material-icons">
                                get_app
                            </i>
                            Descargar
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart1-space', {render:'download',filename:'grafico1'});">
                                PDF</a>
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart1-div', {render:'download',mimeType:'image/svg+xml',filename:'grafico1'});">
                                SVG</a>
                            <a class="dropdown-item" onclick="downloadCsv(1);" download>CSV</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="tab2" role="tabpanel" aria-labelledby="tab2-tab">
                <div class="form-group w-25 mx-auto my-2">
                    <label for="selectSemestre2">Seleccione un semestre:</label>
                    <select class="custom-select custom-select-sm" id="selectSemestre2">
                        <option value=""></option>
                        <jsp:include page="/getFilterData">
                            <jsp:param name="tipo" value="SEMESTRES"/>
                        </jsp:include>
                    </select>
                    <br>
                    <button type="button" class="btn btn-secondary my-3" onclick="crearGrafico2();">Generar gr&aacute;fico</button>
                </div>
                <div id="chart2-space">
                    <header style="display:none; margin-top:24px;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td style="text-align:center;">
                                    <p>Tecnol&oacute;gico de Costa Rica</p>
                                </td>
                                <td style="text-align:center;">
                                    <p>Centro de Vinculaci&oacute;n</p>
                                </td>
                                <td style="text-align:right;">
                                    <p>SISAS PAMTEC</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </header>
                    <footer style="display:none;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td>
                                    <p></p>
                                </td>
                                <td style="text-align:center;">
                                    <p>${currentDateTime}</p>
                                </td>
                                <td style="text-align:right">
                                    <p>Page
                                        <pagenum></pagenum>
                                        of
                                        <totpages></totpages>
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </footer>
                    <div>
                        <br><br><br>
                        <h5>Proyecto Educativo para la Persona Adulta Mayor - PAMTEC</h5>
                        <br>
                        <h6>Estad&iacute;sticas - Cupos matriculados vs abandonos</h6>
                        <br><br><br>
                    </div>
                    <div id="chart2_div" class="mx-auto" style="height: 300px; text-align: center;">
                        <p>No se ha generado el gr&aacute;fico.</p>
                    </div>
                    <div id="chart2_1_div" class="mx-auto" style="height: 300px; max-width: 600px; text-align: center;">
                    </div>
                    <br><br>
                    <p>Este gr&aacute;fico muestra la cantidad de cupos matriculados en un determinado periodo
                        lectivo frente a los cupos que han sido abandonados por alg&uacute;n estudiante PAM.</p>
                </div>
                <hr/>
                <div id="" class="">
                    <div class="dropdown ">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="material-icons">
                                get_app
                            </i>
                            Descargar
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart2-space', {render:'download',filename:'grafico2'});">
                                PDF</a>
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart2-div', {render:'download',mimeType:'image/svg+xml',filename:'grafico2'});">
                                SVG</a>
                            <a class="dropdown-item" onclick="downloadCsv(2);" download>CSV</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="tab3" role="tabpanel" aria-labelledby="tab3-tab">
                <div class="form-group w-25 mx-auto my-2">
                    <label for="selectSemestre3">Seleccione un semestre:</label>
                    <select class="custom-select custom-select-sm" id="selectSemestre3">
                        <option value=""></option>
                        <jsp:include page="/getFilterData">
                            <jsp:param name="tipo" value="SEMESTRES"/>
                        </jsp:include>
                    </select>
                    <br>
                    <button type="button" class="btn btn-secondary my-3" onclick="crearGrafico3();">Generar gr&aacute;fico</button>
                </div>
                <div id="chart3-space">
                    <header style="display:none; margin-top:24px;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td style="text-align:center;">
                                    <p>Tecnol&oacute;gico de Costa Rica</p>
                                </td>
                                <td style="text-align:center;">
                                    <p>Centro de Vinculaci&oacute;n</p>
                                </td>
                                <td style="text-align:right;">
                                    <p>SISAS PAMTEC</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </header>
                    <footer style="display:none;" xmlns:svg="http://www.w3.org/2000/svg">
                        <table width="100%">
                            <tbody>
                            <tr>
                                <td>
                                    <p></p>
                                </td>
                                <td style="text-align:center;">
                                    <p>${currentDateTime}</p>
                                </td>
                                <td style="text-align:right">
                                    <p>Page
                                        <pagenum></pagenum>
                                        of
                                        <totpages></totpages>
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </footer>
                    <div>
                        <br><br><br>
                        <h5>Proyecto Educativo para la Persona Adulta Mayor - PAMTEC</h5>
                        <br>
                        <h6>Estad&iacute;sticas - Matricula vs abandonos al programa</h6>
                        <br><br><br>
                    </div>
                    <div id="chart3_div" class="mx-auto" style="height: 300px; text-align: center;">
                        <p>No se ha generado el gr&aacute;fico.</p>
                    </div>
                    <br><br>
                    <p>Este gr&aacute;fico muestra la cantidad de personas que matricularon en un determinado periodo
                        lectivo frente a las que han sido dadas de baja en todos sus cursos.</p>
                </div>
                <hr/>
                <div id="" class="">
                    <div class="dropdown ">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="material-icons">
                                get_app
                            </i>
                            Descargar
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart3-space', {render:'download',filename:'grafico3'});">
                                PDF</a>
                            <a class="dropdown-item" href="#"
                               onclick="return xepOnline.Formatter.Format('chart3-space', {render:'download',mimeType:'image/svg+xml',filename:'grafico3'});">
                                SVG</a>
                            <a class="dropdown-item" onclick="downloadCsv(3);" download>CSV</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>


</div>
</body>


</html>
