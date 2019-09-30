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
    <link rel="stylesheet" href="../css/estilosBase.css">
    <script src="/SISAS/login/js/transiciones.js"></script>
    <script src="/SISAS/login/js/funciones.js"></script>

    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>


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
        session.removeAttribute("message");
    %>
    -->
    <title>SISAS</title>


</head>
<div class="primary-data-content">
    <body>
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
                        <h3 class="mt-2 ml-5">${cursoName} / Subir Notas</h3>
                    </div>
                </div>
                <div id="cursoBar" class="btn-group btn-group-lg bg-color1 buttonBar "
                     style="text-align: right; width: 100%;" role="group" aria-label="...">
                    <div class="dropdown">
                        <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                                data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                            Asistencia <img class="img-fluid ico-sm" src="../imagenes/asistencia.svg">
                        </button>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                             aria-labelledby="dropdownMenuLista">
                            <a href="javascript:goToPasarLista();" class="dropdown-item">Pasar lista
                                <img class="img-fluid ico-sm" src="../imagenes/registrarAsistencia.svg">
                            </a>
                            <a href="javascript:goToModificarAsistencia()" class="dropdown-item" href="#">Modificar
                                                                                                          asistencia
                                <img class="img-fluid ico-sm" src="../imagenes/editarAsistencia.svg">
                            </a>
                        </div>
                    </div>
                    <div class="dropdown">
                        <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                                data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                            Registro <img class="img-fluid ico-sm" src="../imagenes/registro.svg">
                        </button>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                             aria-labelledby="dropdownMenuLista">
                            <a href="javascript:goToRegistrarAbandono();" class="dropdown-item">Registrar abandono
                                <img class="img-fluid ico-sm" src="../imagenes/abandono.svg">
                            </a>
                            <a class="dropdown-item" href="#">Registrar llamada
                                <img class="img-fluid ico-sm" src="../imagenes/llamada.svg">
                            </a>
                        </div>
                    </div>
                    <div class="dropdown">
                        <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                                data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                            Informaci&oacute;n <img class="img-fluid ico-sm" src="../imagenes/informacion.svg">
                        </button>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                             aria-labelledby="dropdownMenuLista">
                            <a href="javascript:goToInformacionCurso();" class="dropdown-item">Curso
                                <img class="img-fluid ico-sm" src="../imagenes/cursoInfo.svg">
                            </a>
                            <a href="javascript:goToInformacionEstudiante();" class="dropdown-item" href="#">Estudiantes
                                                                                                             PAM
                                <img class="img-fluid ico-sm" src="../imagenes/estudiantesPAM.svg">
                            </a>
                        </div>
                    </div>
                    <div class="dropdown">
                        <button type="button" id="dropdownMenuLista" class="btn btn-outline-secondary bg-color1 btn-lg"
                                data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                            Notas <img class="img-fluid ico-sm" src="../imagenes/notas.svg">
                        </button>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg-left bg-color1"
                             aria-labelledby="dropdownMenuLista">
                            <a class="dropdown-item">Subir notas
                                <img class="img-fluid ico-sm" src="../imagenes/notasRegistrar.svg">
                            </a>
                            <a class="dropdown-item" href="#">Editar notas
                                <img class="img-fluid ico-sm" src="../imagenes/notasEditar.svg">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <form action="/saveNotasCurso" method="post" accept-charset="utf-8" onsubmit="return(validate());"
              enctype="multipart/form-data" class="w-100 text-center">
            <div class="d-flex flex-column justify-content-center overflow-scroll p-3">
                <input type="hidden" name="curso" value="${curso}">
                <div class="overflow-scroll w-75 h-100 p-4 mx-auto">
                    <!-- Ejemplo tabla-->
                    <table class="table h-auto w-100">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nombre</th>
                            <th scope="col" class="text-center">Nota a registrar</th>
                        </tr>
                        </thead>
                        <tbody>
                        <jsp:include page="/getNotasCursoServlet">
                            <jsp:param name="curso" value="${curso}"/>
                        </jsp:include>
                        </tbody>
                    </table>
                    <!-- fin ejemplo -->
                </div>
                <button type="submit" class="btn btn-light bg-gray1 btn-lg mx-auto w-50"> Registrar notas</button>

            </div>
        </form>
    </div>
    </body>
</div>


<%@ include file="/loadingPage/loadingWrapper.jsp" %>

</html>
