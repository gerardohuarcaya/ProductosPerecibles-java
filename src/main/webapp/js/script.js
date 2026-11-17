/*
 * JavaScript compartido de Productos Perecibles.
 * Interacciones comunes para las páginas JSP.
 */
document.addEventListener("DOMContentLoaded", function () {
    // Navegación: resaltar la sección correspondiente a la URL actual.
    const rutaActual = window.location.pathname;
    document.querySelectorAll(".menu-lateral a[href]").forEach(function (enlace) {
        const urlEnlace = new URL(enlace.href, window.location.origin);
        if (urlEnlace.pathname === rutaActual) {
            enlace.classList.add("activo");
            enlace.setAttribute("aria-current", "page");
        }
    });

    // Menú adaptable para pantallas pequeñas.
    const botonMenu = document.querySelector(".menu-toggle");
    const menuPrincipal = document.getElementById("menu-principal");
    if (botonMenu && menuPrincipal) {
        botonMenu.addEventListener("click", function () {
            const abierto = menuPrincipal.classList.toggle("menu-visible");
            botonMenu.setAttribute("aria-expanded", String(abierto));
            botonMenu.setAttribute("aria-label", abierto ? "Ocultar menú" : "Mostrar menú");
            const icono = botonMenu.querySelector("i");
            if (icono) {
                icono.classList.toggle("bi-list", !abierto);
                icono.classList.toggle("bi-x-lg", abierto);
            }
        });
    }

    // Mostrar u ocultar las contraseñas sin modificar el nombre del campo.
    document.querySelectorAll('input[type="password"]').forEach(function (campo) {
        const boton = document.createElement("button");
        boton.type = "button";
        boton.textContent = "Mostrar contraseña";
        boton.className = "mostrar-contrasena";
        boton.setAttribute("aria-label", "Mostrar u ocultar contraseña");
        boton.addEventListener("click", function () {
            const mostrar = campo.type === "password";
            campo.type = mostrar ? "text" : "password";
            boton.textContent = mostrar ? "Ocultar contraseña" : "Mostrar contraseña";
        });
        campo.insertAdjacentElement("afterend", boton);
    });

    // Validación básica: impedir que un campo obligatorio contenga solo espacios.
    document.querySelectorAll("form").forEach(function (formulario) {
        formulario.querySelectorAll("input, textarea").forEach(function (campo) {
            campo.addEventListener("input", function () {
                campo.setCustomValidity("");
            });
        });

        formulario.addEventListener("submit", function (evento) {
            formulario.querySelectorAll(
                "input[required], textarea[required], select[required]"
            ).forEach(function (campo) {
                if (campo.type !== "checkbox" && campo.type !== "radio"
                        && campo.value.trim() === "") {
                    campo.setCustomValidity("Completa este campo.");
                } else {
                    campo.setCustomValidity("");
                }
            });

            if (!formulario.checkValidity()) {
                evento.preventDefault();
                formulario.reportValidity();
            }
        });
    });

    // Establecer la fecha actual como límite mínimo para fechas de vencimiento.
    const hoy = new Date();
    const fechaActual = [
        hoy.getFullYear(),
        String(hoy.getMonth() + 1).padStart(2, "0"),
        String(hoy.getDate()).padStart(2, "0")
    ].join("-");

    document.querySelectorAll('input[type="date"]').forEach(function (campo) {
        if (campo.id === "fecha_vencimiento" || campo.name === "fecha_vencimiento") {
            campo.min = fechaActual;
        }
    });

    // Búsqueda instantánea en tablas cuando existe un campo type="search".
    document.querySelectorAll('input[type="search"]').forEach(function (buscador) {
        buscador.addEventListener("input", function () {
            const seccion = buscador.closest("section") || document;
            const tabla = seccion.querySelector("table");
            if (!tabla || !tabla.tBodies.length) return;

            const texto = buscador.value.trim().toLowerCase();
            Array.from(tabla.tBodies[0].rows).forEach(function (fila) {
                if (fila.querySelector("td[colspan]")) return;
                fila.hidden = !fila.textContent.toLowerCase().includes(texto);
            });
        });
    });

    // Año automático en el pie de página.
    const anio = document.getElementById("anio-actual");
    if (anio) anio.textContent = new Date().getFullYear();

    // Activar tooltips de Bootstrap cuando una página los utilice.
    if (window.bootstrap && bootstrap.Tooltip) {
        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (elemento) {
            new bootstrap.Tooltip(elemento);
        });
    }
});
