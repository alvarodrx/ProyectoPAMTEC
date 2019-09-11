<html>
<head>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="SISAS/css/cosmos.min.css">

    <!-- icon library -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

    <link href='//fonts.googleapis.com/css?family=Marmelad' rel='stylesheet' type='text/css'>
    <title>Programa PAMTEC</title>

    <style>

        body, html {
            height: 100%;
            width: 100%;
            margin: 0px;
            font-family: Arial, serif;
            min-width: 800px;
            min-height: 600px;
        }

        .logo {
            height: 40px;
            width: available;
        }

        .mainMenuBar {
            top: 0;
            z-index: 2;
        }


    </style>

</head>
<body>
<div class="primary-data-content d-flex  align-items-stretch flex-column h-100">
    <div id="mainMenuBar" class="mainMenuBar w-100 shadow position-fixed">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="clearfix w-100" id="navbarColor02">
                <ul class="navbar-nav mr-auto float-left">
                    <li class="nav-item active">
                        <img src="SISAS/imagenes/logoBlanco.png" class="img-fluid logo">
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0 float-right" action="/">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                        <span class="align-top">Sistema de Matricula</span>
                        <i class="material-icons">post_add</i>
                    </button>
                </form>
                <form class="form-inline my-2 my-lg-0 float-right" action="/SISAS/login/">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">
                        <span class="align-top">SISAS</span>
                        <i class="material-icons">playlist_add_check</i>
                    </button>
                </form>
            </div>
        </nav>
    </div>
    <div class="my-3"></div>
    <div class="p-lg-5 w-50 mx-auto">
        <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://storage.googleapis.com/recursos-pamtec/recusos-web/index/logoSinFondo.png"
                         class="d-block w-100 img-fluid" alt="...">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>First slide label</h5>
                        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://storage.googleapis.com/recursos-pamtec/recusos-web/index/fotoGraduacionPamtec.jpg"
                         class="d-block w-100" alt="...">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Second slide label</h5>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://storage.googleapis.com/recursos-pamtec/recusos-web/index/portadaFacebook.jpg"
                         class="d-block w-100" alt="...">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Third slide label</h5>
                        <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>


</div>
</body>
</html>
