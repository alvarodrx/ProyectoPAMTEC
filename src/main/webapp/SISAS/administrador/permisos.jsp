<html>
<%@ include file="/loadingPage/loadingWrapper.jsp" %>
<head>
    <!--
    <%
        String message = "", millis = "", curso = "", cursoName = "", tipoUsuario = "";
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
    <link rel="stylesheet" href="../css/estilosBase.css">
    <script src="${pageContext.request.contextPath}/SISAS/js/transiciones.js"></script>
    <script src="${pageContext.request.contextPath}/SISAS/js/funciones.js"></script>

    <!-- Favicons -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="apple-touch-icon">


    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

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

    </style>

</head>
<div class="primary-data-content d-flex flex-column h-100">
    <body>
    <input type="hidden" id="millis" name="millis" value="${millis}">
    <input type="hidden" id="message" name="message" value="${message}">
    <input type="hidden" id="usuario" name="usuario" value="${usuario}">
    <input type="hidden" id="tipoUsuario" name="tipoUsuario" value="${tipoUsuario}">
    <input type="hidden" id="curso" name="curso" value="${curso}">
    <div id="mainMenuBar" class="mainMenuBar w-100 shadow">
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
        <div class="btn-group-vertical" style="width: 100%">
            <div class="btn-group btn-group-lg w-auto" role="group" aria-label="...">
                <button type="button" class="btn btn-outline-secondary border-0 bg-gray1 btn-lg"
                        onclick=""
                        data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
                    ${usuario}
                </button>
                <div>
                    <h3 class="mt-2 ml-5">${cursoName} | Permisos</h3>
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
                            data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false" onclick="goToInformacionCursosAdmin()">
                        Info. Cursos <img class="img-fluid ico-sm" src="../imagenes/cursoInfo.svg" >
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
    </div>

    <form action="/savePermisosAsistentes" method="post" accept-charset="utf-8" onsubmit="return(validate());"
          enctype="multipart/form-data" class="w-100 text-center">
        <div class="d-flex flex-column justify-content-center overflow-scroll p-3">
            <div class="overflow-scroll w-75 h-100 p-4 mx-auto">
                <!-- Ejemplo tabla-->
                <table class="table h-auto w-100">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Grupo </th>
                        <th scope="col">Nombre Asistente</th>
                        <th scope="col" class="text-center">Permiso</th>
                    </tr>
                    </thead>
                    <tbody>
                    <jsp:include page="/getPermisosAsistentes">
                        <jsp:param name="tipo" value="EstudiantesPAM_Curso"/>
                    </jsp:include>
                    </tbody>
                </table>
                <!-- fin ejemplo -->
            </div>
            <button type="submit" class="btn btn-light bg-gray1 btn-lg mx-auto w-50"> Guardar cambios</button>

        </div>
    </form>


    </body>
</div>




</html>
