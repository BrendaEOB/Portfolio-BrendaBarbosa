// menu
var botaoMenu = document.getElementById("botaoMenu");
var menuMobile = document.getElementById("menuMobile");

botaoMenu.onclick = function() {
    if (menuMobile.style.display == "block") {
        menuMobile.style.display = "none";
    } else {
        menuMobile.style.display = "block";
    }
};

// tema
var botaoTema = document.getElementById("botaoTema");
var corpo = document.body;
var temaSalvo = localStorage.getItem("tema");

if (temaSalvo == "escuro") {
    corpo.className = "escuro";
    botaoTema.innerHTML = "☀️";
}

botaoTema.onclick = function() {
    if (corpo.className == "escuro") {
        corpo.className = "";
        botaoTema.innerHTML = "🌙";
        localStorage.setItem("tema", "claro");
    } else {
        corpo.className = "escuro";
        botaoTema.innerHTML = "☀️";
        localStorage.setItem("tema", "escuro");
    }
};

// texto
var textoDigitando = document.getElementById("textoDigitando");

var textos = [
    "Estudante de TI",
    "Desenvolvedora em formação",
    "Apaixonada por tecnologia"
];

var textoAtual = 0;
var letra = 0;

function digitar() {
    var texto = textos[textoAtual];

    if (letra < texto.length) {
        textoDigitando.innerHTML =
            textoDigitando.innerHTML + texto.charAt(letra);

        letra++;
        setTimeout(digitar, 90);
    } else {
        setTimeout(apagar, 1500);
    }
}

function apagar() {
    var texto = textoDigitando.innerHTML;

    if (texto.length > 0) {
        textoDigitando.innerHTML =
            texto.substring(0, texto.length - 1);

        setTimeout(apagar, 40);
    } else {
        textoAtual++;

        if (textoAtual == textos.length) {
            textoAtual = 0;
        }

        letra = 0;
        digitar();
    }
}

digitar();

// animacao
var elementos = document.getElementsByClassName("reveal");

function animarScroll() {
    var alturaTela = window.innerHeight;

    for (var i = 0; i < elementos.length; i++) {
        var posicao = elementos[i].getBoundingClientRect().top;

        if (posicao < alturaTela - 60) {
            if (elementos[i].className.indexOf("ativo") == -1) {
                elementos[i].className =
                    elementos[i].className + " ativo";
            }
        }
    }
}

window.onscroll = animarScroll;
animarScroll();

// telefone
var telefone = document.getElementById("telefone");

telefone.oninput = function() {
    var valor = telefone.value;

    valor = valor.replace(/\D/g, "");
    valor = valor.substring(0, 11);

    if (valor.length > 2) {
        valor =
            "(" +
            valor.substring(0, 2) +
            ") " +
            valor.substring(2);
    }

    if (valor.length > 10) {
        valor =
            valor.substring(0, 10) +
            "-" +
            valor.substring(10);
    }

    telefone.value = valor;
};