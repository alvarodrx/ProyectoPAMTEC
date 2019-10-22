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
        // Load the Visualization API and the corechart package.
        google.charts.load('current', {'packages':['corechart']});

        // Set a callback to run when the Google Visualization API is loaded.
        google.charts.setOnLoadCallback(drawChart);

        // Callback that creates and populates a data table,
        // instantiates the pie chart, passes in the data and
        // draws it.
        <!-- This adds the proper namespace on the generated SVG -->
        function AddNamespace(){
            var svg = $('#chart_div svg');
            svg.attr("xmlns", "http://www.w3.org/2000/svg");
            svg.css('overflow','visible');
        }
        <!-- This generates the google chart -->
        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Task', 'Hours per Day'],
                ['Work',     10],
                ['Eat',      2],
                ['Commute',  3],
                ['Watch TV', 1],
                ['Exercise', 2],
                ['Sleep',    6]
            ]);

            var options = {
                title: 'My Daily Activities',
            };

            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
            google.visualization.events.addListener(chart, 'ready', AddNamespace);
            chart.draw(data, options);
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
            color:#111;
            background-image: linear-gradient(to bottom,#ffffff 0,#777777 100%);
            background-repeat: repeat-x;
            padding: 5px 10px;
            font-size: 12px;
            line-height: 1.5;
            cursor: pointer;
            border-width:1px;
            border-color: #777;
            text-shadow: 0 -1px 0 rgba(0,0,0,.1);
            box-shadow: inset 0 1px 0 rgba(255,255,255,.15),0 1px 1px rgba(0,0,0,.075);
        }
        #buttons button:hover{
            color:#fff;
            background-image: linear-gradient(to top,#337ab7 0,#265a88 100%);
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
            <div class="clearfix w-100" id="navbarColor02">
                <ul class="navbar-nav mr-auto float-left">
                    <li class="nav-item active">
                        <img src="../imagenes/logoBlanco.png" class="img-fluid logo">
                    </li>
                </ul>
                <form class="form-inline my-auto float-right" action="/weblogin">
                    <input type="hidden" name="tipo" value="SALIR">
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
                        onclick="#"
                        data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                    ${usuario}
                </button>
                <div>
                    <h3 class="mt-2 ml-5">Administrador SISAS | Permisos</h3>
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
                        <a class="dropdown-item" href="javascript:goToEditarNotaAdmin()">Editar notas
                            <img class="img-fluid ico-sm" src="../imagenes/notasEditar.svg">
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

    <div id="charts-content" class="w-100 text-center" style="margin-top: 160px;">
        <div id="buttons" class="buttons">
            <button onclick="return xepOnline.Formatter.Format('JSFiddle', {render:'download', srctype:'svg'})">PDF</button>
        </div>
        <hr/>
        <div id="JSFiddle">
            <div id="chart_div" style="width: 1100px; height: 500px;"></div>
        </div>



        <div class="btn-group">
            <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" id="printit" href="#">
                <i class="fa fa-download"></i><span> Download</span>
            </a>
            <ul class="dropdown-menu">
                <li>
                    <a href="#"
                       onclick="return xepOnline.Formatter.Format('Google2DPieCharts', {render:'download',filename:'Google2DPieCharts'});">As
                        PDF</a></li>
                <li>
                    <a href="#"
                       onclick="return xepOnline.Formatter.Format('Google2DPieCharts', {render:'download',mimeType:'image/svg+xml',filename:'Google2DPieCharts'});">As
                        SVG</a>
                </li>
                <li role="separator" class="divider"></li>
                <li>
                    <a href="#"
                       onclick="return xepOnline.Formatter.Format('Google2DPieCharts', {render:'download',mimeType:'application/postscript',filename:'Google2DPieCharts'});">As
                        Postscript</a>
                </li>
                <li>
                    <a href="#"
                       onclick="return xepOnline.Formatter.Format('Google2DPieCharts', {render:'download',mimeType:'application/vnd.ms-xpsdocument',filename:'Google2DPieCharts'});">As
                        XPS</a>
                </li>
                <li role="separator" class="divider"></li>
                <li>
                    <a href="#"
                       onclick="return xepOnline.Formatter.Format('Google2DPieCharts', {render:'download',mimeType:'application/xep',filename:'Google2DPieCharts'});">As
                        XEPOUT</a>
                </li>
            </ul>
        </div>

    </div>


</div>
</body>


</html>
