<html>
<head>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/cosmos.min.css">

    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="../css/estilosBase.css">
    <script src="${pageContext.request.contextPath}/SISAS/js/transiciones.js"></script>
    <script src="${pageContext.request.contextPath}/SISAS/js/funciones.js"></script>

    <!--
    <%
        String message = "", millis = "", curso = "", cursoName = "", estudiantePAM = "", fecha = "";
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
        session.removeAttribute("message");

        estudiantePAM = request.getParameter("estudiantePAM");
        pageContext.setAttribute("estudiantePAM", estudiantePAM);

        fecha = request.getParameter("fecha");
        pageContext.setAttribute("fecha", fecha);

    %>
    -->
    <title>SISAS</title>


</head>

<body>
<div class="primary-data-content">
    <div class="d-flex flex-column h-100 align-items-stretch">
        <input type="hidden" id="millis" name="millis" value="${millis}">
        <input type="hidden" id="message" name="message" value="${message}">
        <input type="hidden" id="curso" name="curso" value="${curso}">
        <div id="mainMenuBar" class="mainMenuBar w-100 shadow">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="clearfix w-100" id="navbarColor02">
                    <ul class="navbar-nav mr-auto float-left">
                        <li class="nav-item active">
                            <img src="../imagenes/logoBlanco.png" class="img-fluid logo">
                        </li>
                    </ul>
                    <form class="form-inline my-2 my-lg-0 float-right" action="/weblogin?tipo=SALIR">
                        <button class="btn btn-secondary my-auto" type="submit">
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
                        <h3>Informaci&oacute;n de Cursos</h3>
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
                                data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false"
                                onclick="goToEstadisticasAdmin()">
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
            <form action="" method="post" accept-charset="utf-8" class="w-100 text-center">
                <!-- Informacion de Curso -->
                <div class="d-flex justify-content-center  p-3 ">
                    <div class="jumbotron w-75 rounded-lg shadow ">

                        <div class="text-left">
                            <div class="row w-150">
                                <div class="col float-left">
                                    <label><b>Seleccionar Curso:</b></label>
                                </div>
                                <div class="col float-right">
                                    <form action="" method="post">
                                        <select class="custom-select custom-select-sm" name="fecha"
                                                onchange="$('#changeFechas').click();">
                                            <option value="">Curso</option>
                                            <jsp:include page="/getFechaAsistenciaGrupo">
                                                <jsp:param name="curso" value="${curso}"/>
                                                <jsp:param name="fecha" value="${fecha}"/>
                                            </jsp:include>
                                        </select>
                                        <button type="submit" hidden id="changeFechas"></button>
                                    </form>
                                </div>


                                <div class="col float-left">
                                    <label><b>Seleccionar Grupo:</b></label>
                                </div>
                                <div class="col float-right">
                                    <form action="" method="post">
                                        <select class="custom-select custom-select-sm" name="fecha"
                                                onchange="$('#changeFechas').click();">
                                            <option value="">Grupo</option>
                                            <jsp:include page="/getFechaAsistenciaGrupo">
                                                <jsp:param name="curso" value="${curso}"/>
                                                <jsp:param name="fecha" value="${fecha}"/>
                                            </jsp:include>
                                        </select>
                                        <button type="submit" hidden id="changeFechas"></button>
                                    </form>
                                </div>

                            </div>
                        </div>
                        &nbsp

                        <h3>Informaci&oacuten del Curso</h3>
                        <br>
                        <jsp:include page="/getInfoCurso">
                            <jsp:param name="curso" value="${curso}"/>
                        </jsp:include>
                        <div class="row">
                            <div class="column">

                                <br>
                                <b class="izquierda">Lugar:</b>
                                <label id="labelLugar" class="derecha">Laboratorio H - Azul</label>
                                <br>
                                <b class="izquierda">Horario:</b>
                                <label id="labelHorario" class="derecha">Lunes 3:pm a 5:pm</label>
                                <br>
                            </div>
                            <div class="column">
                                <br>
                                <b class="izquierda">Inicio:</b>
                                <label id="labelCInicio" class="derecha">05/02/2020</label>
                                <br>
                                <b class="izquierda">Fin:</b>
                                <label id="labelFin" class="derecha">05/08/2020</label>
                                <br>
                            </div>
                        </div>
                        <br>
                        <b class="izquierda">Asistentes del Curso</b>
                        <br>
                        <jsp:include page="/getInfoCursoAsistentes">
                            <jsp:param name="curso" value="${curso}"/>
                        </jsp:include>
                    </div>
                </div>
                <!-- Informacion de curso end -->

            </form>
        </div>
    </div>
</div>
</body>
<%@ include file="/loadingPage/loadingWrapper.jsp" %>

</html>
